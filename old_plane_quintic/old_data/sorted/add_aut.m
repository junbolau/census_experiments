OutputFileName := "aut_" cat InputFileName;
LinesOfInputFile := Split(Read(InputFileName), "\n");

function LineCount(F)
    FP := Open(F, "r");
    count := 0;
    while true do
        line := Gets(FP);
        if IsEof(line) then
            break;
        end if;
        count +:= 1;
    end while;
    return count;
end function;

L := LineCount(InputFileName);

R<x0,x1,x2>:= PolynomialRing(GF(2),3);
X := ProjectiveSpace(R);
monos5 := [x0^5, x0^4*x1, x0^4*x2, x0^3*x1^2, x0^3*x1*x2, x0^3*x2^2, x0^2*x1^3, x0^2*x1^2*x2, x0^2*x1*x2^2, x0^2*x2^3, x0*x1^4, x0*x1^3*x2, x0*x1^2*x2^2, x0*x1*x2^3, x0*x2^4, x1^5, x1^4*x2, x1^3*x2^2,x1^2*x2^3, x1*x2^4, x2^5];

function FFConstruction(fsupp)
    pol := R!0;
    for k in fsupp do
        pol +:= monos5[k+1];
        end for;
    Y_ := Scheme(X,pol);
    C_ := Curve(Y_);
    return pol,#AutomorphismGroup(C_);
end function;

i := 1;

while i le L do
    lst := eval(LinesOfInputFile[i]);
    output_pol,aut_size := FFConstruction(lst);
    fprintf OutputFileName, "[" cat "%o" cat "," cat "%o" cat "]" cat "\n", output_pol,aut_size;
    i +:= 1;
end while;

quit;
