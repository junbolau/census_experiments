/*

find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../../curves_by_ramification.m &\n"' > RUN
emacs -nw RUN
add #!/bin/sh
chmod u+x RUN
./RUN

*/

/*

Search strategy:
1. Filenames are of the form r1_rmr1.txt to represent tuples (r1, r-r1), where r is the number of geom ram pts, r1 is the number of F_2-rational ram pts. Note that 0 <= r <= 5 and r-r1 != 1.
2.

*/



OutputFileName := InputFileName;

r_1 := StringToInteger(InputFileName[1]);
rmr1 := StringToInteger(InputFileName[3]);

P<x,y,z> := ProjectiveSpace(FiniteField(2),2);

// Checks for elliptic curve at the base
dir := GetCurrentDirectory();
if dir[#dir] eq "1" then
    f := y^2 *z + y*z^2 + x^3 + x*z^2 + z^3;
elif dir[#dir] eq "2" then
    f := y^2*z + x*y*z + y*z^2 + x^3 + z^3;
elif dir[#dir] eq "3" then
    f := y^2*z + y*z^2 + x^3;
elif dir[#dir] eq "4" then
    f := y^2 *z + x*y*z + x^3 + z^3;
elif dir[#dir] eq "5" then
    f := y^2*z + y*z^2 + x^3 + x*z^2;
end if;

E := Curve(P,f);
F0 := AlgorithmicFunctionField(FunctionField(E));
B := Parent(DefiningPolynomial(F0));
A := BaseRing(B);
AssignNames(~A,["x"]);
AssignNames(~B,["y"]);
iD := Identity(DivisorGroup(F0));

RamDivisor := function(r_1,rmr1);
    if r_1 ne 0 then
        if rmr1 eq 0 then
            place_lst := [Places(F0,1)];
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            for plset1 in S1 do
                divs := iD;
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                divs := 2*divs;
                Append(~lst,divs);
            end for;
            return lst;
        elif rmr1 eq 2 then
            place_lst := [Places(F0,1),Places(F0,2)];
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            for p_2 in place_lst[2] do
                for plset1 in S1 do
                    divs := iD + p_2;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst,divs);
                end for;
            end for;
            return lst;
        elif rmr1 eq 3 then
            place_lst := [Places(F0,1),Places(F0,3)];
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            for p_3 in place_lst[2] do
                for plset1 in S1 do
                    divs := iD + p_3;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst,divs);
                end for;
            end for;
            return lst;
        elif rmr1 eq 4 then
            place_lst := [Places(F0,1),Places(F0,2),Places(F0,4)];
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst1 := [];
            for p_4 in place_lst[3] do
                for plset1 in S1 do
                    divs := iD + p_4;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst1,divs);
                end for;
            end for;

            S2 := Multisets(Seqset(place_lst[2]),2);
            lst2 := [];
            for plset1 in S1 do
                divs_tmp := iD;
                for p_1 in plset1 do
                    divs_tmp +:= p_1;
                end for;
                divs := divs_tmp;
                for plset2 in S2 do
                    for p_2 in plset2 do
                        divs +:= p_2;
                    end for;
                    divs := 2*divs;
                    Append(~lst2,divs);
                    divs := divs_tmp;
                end for;
            end for;
            return lst1 cat lst2;
        elif rmr1 eq 5 then
            place_lst := [Places(F0,1),Places(F0,2),Places(F0,3),Places(F0,5)];
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst1 := [];
            for p_5 in place_lst[4] do
                for plset1 in S1 do
                    divs := iD + p_5;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst1,divs);
                end for;
            end for;

            lst2 := [];
            for p_2 in place_lst[2] do
                for p_3 in place_lst[3] do
                    for plset1 in S1 do
                        divs := iD + p_2 + p_3;
                        for p_1 in plset1 do
                            divs +:= p_1;
                        end for;
                        divs := 2*divs;
                        Append(~lst2,divs);
                    end for;
                end for;
            end for;
            return lst1 cat lst2; 
        end if;
    elif r_1 eq 0 then
        if rmr1 eq 0 then
            return [iD];
        elif rmr1 eq 2 then
            return [iD + 2*(p_2): p_2 in Places(F0,2)];
        elif rmr1 eq 3 then
            return [iD + 2*(p_3): p_3 in Places(F0,3)];
        elif rmr1 eq 4 then
            place_lst:=[Places(F0,2),Places(F0,4)];
            S2 := Multisets(Seqset(place_lst[1]),2);
            lst := [];
            for plset2 in S2 do
                divs := iD;
                for p_2 in plset2 do
                    divs +:= p_2;
                end for;
                divs := 2*divs;
                Append(~lst,divs);
            end for;
            return [iD + 2*(p_4): p_4 in place_lst[2]] cat lst;
        elif rmr1 eq 5 then
            place_lst:=[Places(F0,2),Places(F0,3),Places(F0,5)];
            return [iD + 2*(p_5): p_5 in place_lst[3]] cat [iD + 2*(p_2 + p_3): p_2 in place_lst[1],p_3 in place_lst[2]];
        end if;
    end if;
end function;

//places_lst := PlacesCreation(rmr1);
for d in RamDivisor(r_1,rmr1) do
    R,mR := RayClassGroup(d);
    gens := SetToIndexedSet(Generators(R));
    U1 := sub<R| [2*g : g in gens]>;

    V := VectorSpace(GF(2), #gens);
    for v in V do
        if v eq V!0 then
            continue;
        else
            m := Depth(v); //first nonzero entry of v
            U2:= sub<R|[gens[i1] - (Integers()! v[i1])*gens[m] : i1 in [1..#gens]]>;
            U3:= sub<R|[U1, U2]>;
            Ab := AbelianExtension(d,U3);
            F1:= FunctionField(Ab);

           if Genus(F1) eq 6 then
               cpc := ([NumberOfPlacesOfDegreeOneECF(F1,n) : n in [1..6]]);
               pol:=DefiningPolynomial(RationalExtensionRepresentation(F1));
               fprintf OutputFileName, "[" cat "%o" cat "%o" cat "]" cat "\n", pol,cpc;
           end if;
        end if;
    end for;
end for;

quit;
