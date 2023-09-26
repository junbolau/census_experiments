/*curve_check.m

  Use this script to generate torsion prime data:

    ls ./data/ | parallel -j25 "magma -b InputFileName:={} curve_check.m"

  This will take the data files in `./data/`, and for each curve in each file,
  will generate a new file (appended with `with_genus`) in the same directory.

*/


RealInputFileName := "./data/" cat InputFileName;
OutputFileName := "./data/" cat "with_genus_" cat InputFileName;

LinesOfInputFile := Split(Read(RealInputFileName), "\n");

R<x0,x1,x2> := PolynomialRing(GF(2),3);
X := ProjectiveSpace(R);
monos5 := [x0^5, x0^4*x1, x0^4*x2, x0^3*x1^2, x0^3*x1*x2, x0^3*x2^2, x0^2*x1^3, x0^2*x1^2*x2, x0^2*x1*x2^2, x0^2*x2^3, x0*x1^4, x0*x1^3*x2, x0*x1^2*x2^2, x0*x1*x2^3, x0*x2^4, x1^5, x1^4*x2, x1^3*x2^2,x1^2*x2^3, x1*x2^4, x2^5];

GenusCheck := function(_fsupp)
    fsupp := eval(_fsupp);
    pol := R!0;
    for i in fsupp do
        pol +:= monos5[i+1];
    end for;
    Y := Scheme(X,pol);
    if Dimension(Y) eq 1 and IsIrreducible(Y) eq true and IsReduced(Y) eq true then
        C := Curve(Y);
        F0 := FunctionField(C);
        F := AlgorithmicFunctionField(F0);
        if Genus(F) eq 6 then
            ct := "[";
            for n in [1..4] do
                ct :=  ct cat IntegerToString(NumberOfPlacesOfDegreeOneECF(F,n)) cat ",";
            end for;
            Prune(~ct);
            ct := ct cat "]"; 
            return true, ct;
        else
            return false, "";
        end if; 
    else
        return false, "";
    end if;
end function;
    

for MyLine in LinesOfInputFile do
    boo,ct := GenusCheck(MyLine);
    if boo eq true then
        to_print := "[" cat ct cat "," cat MyLine cat "]" cat "\n";
        fprintf OutputFileName, to_print;
    end if;
end for;

quit;
    
