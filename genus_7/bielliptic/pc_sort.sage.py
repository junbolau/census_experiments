

# This file was *autogenerated* from the file pc_sort.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_6 = Integer(6); _sage_const_0 = Integer(0); _sage_const_20 = Integer(20)
from collections import defaultdict

R = PolynomialRing(GF(_sage_const_2 ), names=('x', 'y',)); (x, y,) = R._first_ngens(2)
curves = defaultdict(set)

for i in range(_sage_const_1 ,_sage_const_6 ):
    f = open('data/' + str(i) + ".txt","r").readlines()
    for l in f:
        lst = sage_eval(l,{'x':x,'y':y})
        curves[tuple(lst[_sage_const_0 ])].add((lst[_sage_const_1 ][_sage_const_0 ],lst[_sage_const_2 ][_sage_const_0 ]))

k_lst = list(curves.keys())
jump = ceil(len(k_lst)/_sage_const_20 )
for j in range(_sage_const_20 ):
    g = open('data/sorted_' + str(j) + '.txt','w+')
    for k in k_lst[jump*j:jump*j + jump]:
        for curve_tup in curves[k]:
            g.write(str([list(k),[curve_tup[_sage_const_0 ],curve_tup[_sage_const_1 ]]]))
            g.write('\n')
    g.close()    
