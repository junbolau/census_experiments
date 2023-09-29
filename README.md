# genus_6_census


## Obtaining LMFDB data

Run ```sage``` in your local ```/lmfdb/``` folder

```
from lmfdb import db
av_isog = db.av_fq_isog
info = {}
lst = av_isog.search({'p':2,'g':6,'has_jacobian':{'$gte':0},'has_principal_polarization':{'$gte':0}},projection=['poly','p_rank'])


R.<T> = PolynomialRing(QQ)
file = open('../genus_6_census/Shared/weilpolys_p_rank.sage','w')
for i in lst:
    pol= [sum( (i['poly'][j])*T^(12-j) for j in range(13)), int(i['p_rank'])]
    file.write(str(pol) + '\n')
file.close()
```
