/*isom_class_check.m

  Use this script to generate isomorphism class of curves data:

    ls ./data/sorted_data/ | parallel -j25 "magma -b InputFileName:={} isom_class_check.m"
    
  (current) If parallel does not work, run this script within /data/ directory :
  
  find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../isom_class_check.m &\n"' > RUN
  emacs -nw RUN
  chmod u+x RUN
  ./RUN
  
  Comments on the current method:
  - find ./ -type f | grep txt | grep ^./with  | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../isom_class_check.m &\n"' > RUN
  - writes a bash script file to run magma file in parallel. need to select files with certain beginnings, #!/bin/sh on top on RUN
  - use several data folders to manage batches (BU server limit)
  - approx 30-35 .txt files in each data folder

  This will take the data files in `./data/`, and for each curve in each file,
  will generate a new file (appended with `isomclass_`) in the same directory.

*/

/*

 parallel:
 
 RealInputFileName := "./data/" cat InputFileName;
 OutputFileName := "-/data/with_genus_" cat InputFileName;

*/


OutputFileName := "isomclass_" cat InputFileName;
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
    F_ := FunctionField(C_);
    return AlgorithmicFunctionField(F_);
end function;


lst := eval(LinesOfInputFile[1]);
pol := R!0;
for k in lst[2] do
    pol +:= monos5[k+1];
end for;

final := [lst[2]];
ignore_lst := {};


for i in [1..L] do
    if i in ignore_lst eq false then
    
        lst := eval(LinesOfInputFile[i]);
        ct := lst[1];
        supp := lst[2];
        F0 := FFConstruction(supp);
        
        tmp := [F0];
        Include(~ignore_lst,i);
        
        for j in [i+1..L] do
            lst2 := eval(LinesOfInputFile[j]);
            ct1 := lst2[1];
            supp1 := lst2[2];
            if ct eq ct1 then
                F0g := FFConstruction(supp1);
                if forall(u){m : m in tmp | IsIsomorphic(F0g,m) eq false } eq true then
                    Append(~tmp, F0g);
                    Append(~final,supp1);
                    Include(~ignore_lst,j);
                    end if;
            else
                continue;
            end if;
        end for;
    else
        continue;
    end if;
end for;


for i in final do
    fprintf OutputFileName, "%o" cat "\n", i;
end for;

quit;
