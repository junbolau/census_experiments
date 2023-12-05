// redundant
// magma -b InputFileName:=ram.txt ../../curve_check.m &

OutputFileName := "curve.txt";
LinesOfInputFile := Split(Read(InputFileName), "\n");

L := #LinesOfInputFile;

A<x,y>:= AffineSpace(GF(2),2);

for i in [1..L] do
    lst := eval(LinesOfInputFile[i]);
    supp := lst[2];
    C := Curve(A, supp);
    if Dimension(C) eq 1 and IsIrreducible(C) eq true and IsReduced(C) eq true then
        fprintf OutputFileName, "%o" cat "\n", LinesOfInputFile[i];
    end if;
end for;

quit;