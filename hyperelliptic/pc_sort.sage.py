

# This file was *autogenerated* from the file pc_sort.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_0 = Integer(0); _sage_const_1 = Integer(1); _sage_const_25 = Integer(25); _sage_const_134 = Integer(134)
from collections import defaultdict

f = open("data/pc_unfiltered.txt",'r').readlines()
R = PolynomialRing(GF(_sage_const_2 ), names=('x', 'y',)); (x, y,) = R._first_ngens(2)
d = defaultdict(list)
for line in f:
    lst = sage_eval(line,{'x':x,'y':y})
    d[tuple(lst[_sage_const_0 ])].append([lst[_sage_const_1 ]])
    
lst = list(d.keys())
for j in range(_sage_const_25 ):
    f = open('data/sorted_' + str(j) + '.txt','w+')
    for key in lst[_sage_const_134 *j:_sage_const_134 *j + _sage_const_134 ]:
        for eqn in d[key]:
            tmp = [list(key),list(eqn)]
            f.write(str(tmp))
            f.write('\n')
    f.close()

