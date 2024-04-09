from collections import defaultdict

R.<x,y> = PolynomialRing(GF(2))
curves = defaultdict(set)

for i in range(1,6):
    f = open('data/' + str(i) + ".txt","r").readlines()
    for l in f:
        lst = sage_eval(l,{'x':x,'y':y})
        curves[tuple(lst[0])].add((lst[1][0],lst[2][0]))

k_lst = list(curves.keys())
jump = ceil(len(k_lst)/20)
for j in range(20):
    g = open('data/sorted_' + str(j) + '.txt','w+')
    for k in k_lst[jump*j:jump*j + jump]:
        for curve_tup in curves[k]:
            g.write(str([list(k),[curve_tup[0],curve_tup[1]]]))
            g.write('\n')
    g.close()
