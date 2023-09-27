# This file contains calculations for plane quintic curves of genus 6 over F_2.

- ```data_generation.ipynb``` contains various functions to create a list of point counts, Weil polynomials and then a dictionary of possible equations in bins of point counts. This is then broken ```unfiltered_*.txt```  in ```/data```.
- ```curve_check.m``` Checks if each equation define a curve.
- ```isom_class_check.m``` Checks for pairwise isomorphism from ```with_genus_unfiltered_*.txt``` in ```/data```. The resulting data is saved under ```/data/sorted``` in batches or in the final file ```plane_quintic.txt```.
