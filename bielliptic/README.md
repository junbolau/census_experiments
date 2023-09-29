# This file contains calculations for bielliptic curves of genus 6 over F_2.

The file is broken into 3 steps: data generation, curve check and isomorphism class check.

- ```data_generation.ipynb``` contains various functions to create a list of point counts, Weil polynomials and then a dictionary of possible equations in bins of point counts. We reduce the number of possible pairs (C -> E) by 
* Using a refinement of the resultant 2 method (Corollary 9.3 The relative class number one problem for function fields, I, K.S. Kedlaya)
* #C(F_2^i) <= 2*#E(F_2^i)
* Deuring-Shafarevich formula: gamma_C -1 = d(gamma_E -1) + t, where t is the number of geometric ramification points
* #C(F_2^2i) >= 2*#E(F_2^i) - t
* when t <= 2, (#C(F_2^2j-1) - #E(F_2)) %2 == 0

- ```curve_check.m``` Checks if each equation define a curve.
- ```isom_class_check.m``` Checks for pairwise isomorphism from ```with_genus_unfiltered_*.txt``` in ```/data```. The resulting data is saved under ```/data/sorted``` in batches or in the final file ```plane_quintic.txt```.

## Comments:
- breaking down the list of equations into 25 files allow parallelising the curve and isomorphism class checks. The commands are contained within the Magma files.
- Takes less than 2 hours when broken down into 25 parallel Magma jobs. Optimisations possible.
- Can break down into batches in a smarter way depending on bin sizes.




