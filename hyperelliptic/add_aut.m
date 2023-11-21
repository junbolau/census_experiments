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

A<x,y>:= AffineSpace(GF(2),2);

function FFConstruction(fsupp)
    C_ := Curve(A,fsupp);
    return fsupp,#AutomorphismGroup(C_);
end function;

i := 1;

while i le L do
    lst := eval(LinesOfInputFile[i]);
    output_pol,aut_size := FFConstruction(lst);
    fprintf OutputFileName, "[" cat "%o" cat "," cat "%o" cat "]" cat "\n", output_pol,aut_size;
    i +:= 1;
end while;

quit;
