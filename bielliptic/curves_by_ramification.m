/*

find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../../curves_by_ramification.m &\n"' > RUN
emacs -nw RUN
#!/bin/sh


*/

OutputFileName := InputFileName;

r_1 := StringToInteger(InputFileName[1]);
rmr1 := StringToInteger(InputFileName[3]);

A<x,y> := AffineSpace(FiniteField(2),2);
dir := GetCurrentDirectory();
if dir[#dir] eq "1" then
    f := y^2 + y + x^3 + x + 1;
elif dir[#dir] eq "2" then
    f := y^2 + x*y + y + x^3 + 1;
elif dir[#dir] eq "3" then
    f := y^2 + y + x^3;
elif dir[#dir] eq "4" then
    f := y^2 + x*y + x^3 + 1;
elif dir[#dir] eq "5" then
    f := y^2 + y + x^3 + x;
end if;

E := Curve(A,f);
F0 := AlgorithmicFunctionField(FunctionField(E));
iD := Identity(DivisorGroup(F0));

PlacesCreation := function(rmr1)
    places0 := Places(F0,1);
    if rmr1 eq 0 then
        return [places0,[],[],[]];
    elif rmr1 eq 2 then
        return [places0,Places(F0,2),[],[]];
    elif rmr1 eq 3 then
        return [places0,Places(F0,3),[],[]];
    elif rmr1 eq 4 then
        return [places0,Places(F0,2),Places(F0,4),[]];
    elif rmr1 eq 5 then
        return [places0,Places(F0,2),Places(F0,3),Places(F0,5)];
    else
        return [[],[],[].[]];
    end if;
end function;

RamDivisor := function(r_1,rmr1);
    place_lst := PlacesCreation(rmr1);
    if r_1 ne 0 then
        if rmr1 eq 0 then
            return [2*(iD + &+p_1): p_1 in Subsets(Seqset(place_lst[1]),r_1)];
        elif rmr1 eq 2 then
            return [2*(iD + &+p_1 + p_2): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in place_lst[2]];
        elif rmr1 eq 3 then
            return [2*(iD + &+p_1 + p_3): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_3 in place_lst[2]];
        elif rmr1 eq 4 then
            return [2*(iD + &+p_1 + p_4): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_4 in place_lst[3]] cat [2*(iD + &+p_1 + &+p_2): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in Subsets(Seqset(place_lst[2]),2)];
        elif rmr1 eq 5 then
            return [2*(iD + &+p_1 + p_5): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_5 in place_lst[4]] cat [2*(iD + &+p_1 + p_2 + p_3): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in place_lst[2],p_3 in place_lst[3]];
        end if;
    elif r_1 eq 0 then
        if rmr1 eq 2 then
            return [2*(iD + p_2): p_2 in place_lst[2]];
        elif rmr1 eq 3 then
            return [2*(iD + p_3): p_3 in place_lst[2]];
        elif rmr1 eq 4 then
            return [2*(iD + p_4): p_4 in place_lst[3]] cat [2*(iD + &+p_2): p_2 in Subsets(Seqset(place_lst[2]),2)];
        elif rmr1 eq 5 then
            return [2*(iD + p_5): p_5 in place_lst[4]] cat [2*(iD + p_2 + p_3): p_2 in place_lst[2],p_3 in place_lst[3]];
        end if;
    end if;
end function;

places_lst := PlacesCreation(rmr1);
for d in RamDivisor(r_1,rmr1) do
    R,mR := RayClassGroup(d);
    gens := SetToIndexedSet(Generators(R));
    U1 := [2*g : g in gens];

    V := VectorSpace(GF(2), #gens);
    for v in V do
        if v eq V!0 then
            continue;
        else
            m := Depth(v);
            U2:= [gens[i1] - (Integers()! v[i1])*gens[m] : i1 in [1..#gens]];
            U3:= sub<R|U1 cat U2>;
            A := AbelianExtension(d,U3);
            F1:= FunctionField(A);
            if Genus(F1) eq 6 then
                cpc := ([NumberOfPlacesOfDegreeOneECF(F1,n) : n in [1..6]]);
                fprintf OutputFileName, "%o" cat "\n", F1;
                fprintf OutputFileName, "%o" cat "\n", cpc;
            end if;
        end if;
    end for;
end for;

quit;
