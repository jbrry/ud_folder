#!/usr/bin/env python2

# usage:
# fgrep "total-LAS-F1" -A 1 dev-okia-wsc*e1s3*eval/eval*pro* | ./average-wscale.py > wscale-summary.tsv

input_example = """
--
dev-okia-wscale-5000-e1s3v2-run-35-eval/evaluation.prototext:  key: "total-LAS-F1"
dev-okia-wscale-5000-e1s3v2-run-35-eval/evaluation.prototext-  value: "79.85"
--
dev-okia-wscale-500-e1s3v2-run-1-eval/evaluation.prototext:  key: "total-LAS-F1"
dev-okia-wscale-500-e1s3v2-run-1-eval/evaluation.prototext-  value: "79.86"
--
best_mbist_mono_runs_master/seed-201/eval/evaluation.prototext:  key: "total-LAS-F1"
best_mbist_mono_runs_master/seed-201/eval/evaluation.prototext-  value: "81.600774064"
"""

# or
# dev-okia-e1s3v2-hierarchical-prunelabels-run-300-eval/evaluation.prototext:  key: "total-LAS-F1"
# dev-okia-e1s3v2-hierarchical-prunelabels-run-300-eval/evaluation.prototext-  value: "79.72"

import math
import random
import sys

max_samples = 0
if '--max-samples' in sys.argv:
    index = sys.argv.index('--max-samples')
    max_samples = int(sys.argv[index+1])
    del sys.argv[index+1]
    del sys.argv[index]

key2scores = {}

while True:
    line = sys.stdin.readline()
    if not line:
        break
    line = line.replace('"', ' ')
    line = line.replace('-', ' ')
    line = line.replace('/', ' ')
    line = line.replace('_', ' ')
    fields = line.split()
    if 'value:' in fields:
        if fields[-2] != 'value:':
            raise ValueError, 'unknown line format'
        score = float(fields[-1])
        if score < 5.0:
            sys.stderr.write('Ignoring score %.2f\n' %score)
            continue
        if fields[2] == 'wscale':
            wscale = int(fields[3])
            model  = fields[4]
            key = (model, wscale, 'default')
        elif fields[2] in ('e1s3v2', 'e3s6v2', 'e5s8v2'):
            param = '-'.join(fields[3:fields.index('run')])
            wscale = 0
            model  = fields[2]
            key = (model, wscale, param)
        elif fields[0] == 'best':
            param = '-'.join(fields[1:fields.index('seed')])
            key = (param, 0, 'default')
        else:
            raise ValueError, 'unknown line format'
        if key not in key2scores:
            key2scores[key] = []
        key2scores[key].append(score)

for key in sorted(key2scores.keys()):
    row = []
    model, wscale, param = key
    row.append(model)
    row.append('%d' %wscale)
    row.append(param)
    scores = key2scores[key]
    if max_samples and len(scores) > max_samples:
        low_precision = []
        high_precision = []
        for score in scores:
            sscore = '%.9f' %score
            if sscore.endswith('0000000'):
                low_precision.append(score)
            else:
                high_precision.append(score)
        random.shuffle(high_precision)
        scores = high_precision[:max_samples]
        if len(scores) < max_samples:
            random.shuffle(low_precision)
            scores = scores + low_precision[:max_samples-len(scores)]
    info = `scores`
    # basic stats
    n = len(scores)
    avg = sum(scores) / float(n)
    a = min(scores)
    b = max(scores)
    d = b-a
    # binomially-weighted average
    scores.sort()
    s = 0.0
    p = 0.5 ** (n-1)
    for i in range(n):
        w = math.factorial(n-1) // (math.factorial(i) * math.factorial(n-1-i))
        #print n, i, w, w*p
        s += (w*p*scores[i])
    # stddev
    v = 0.0
    if n >= 2:
        for x in scores:
            v += (x-avg)**2
        v = v / float(n-1)
        v = v ** 0.5
    # median
    while len(scores) > 2:
        del scores[-1]
        del scores[0]
    m = sum(scores) / float(len(scores))
    row.append('%.9f' %avg)
    row.append('%.9f' %m)
    row.append('%.9f' %s)
    row.append('%.9f' %a)
    row.append('%.9f' %b)
    row.append('%.9f' %d)
    row.append('%.9f' %v)
    row.append('%d' %n)
    #row.append(info)
    sys.stdout.write('\t'.join(row))
    sys.stdout.write('\n')

