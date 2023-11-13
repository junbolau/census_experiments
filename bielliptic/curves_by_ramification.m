/*

find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../../curves_by_ramification.m &\n"' > RUN
emacs -nw RUN
add #!/bin/sh
chmod u+x RUN
./RUN

*/

OutputFileName := InputFileName;

r_1 := StringToInteger(InputFileName[1]);
rmr1 := StringToInteger(InputFileName[3]);

P<x,y,z> := ProjectiveSpace(FiniteField(2),2);
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

PlacesCreation := function(rmr1)
    places1 := Places(F0,1);
    if rmr1 eq 0 then
        return [places1,[],[],[]];
    elif rmr1 eq 2 then
        return [places1,Places(F0,2),[],[]];
    elif rmr1 eq 3 then
        return [places1,Places(F0,3),[],[]];
    elif rmr1 eq 4 then
        return [places1,Places(F0,2),Places(F0,4),[]];
    elif rmr1 eq 5 then
        return [places1,Places(F0,2),Places(F0,3),Places(F0,5)];
    else
        return [[],[],[].[]];
    end if;
end function;


RamDivisor := function(r_1,rmr1);
    place_lst := PlacesCreation(rmr1);
    if r_1 ne 0 then
        if rmr1 eq 0 then
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            divs := iD;
            for plset1 in S1 do
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                divs := 2*divs;
                Append(~lst,divs);
                divs := iD;
            end for;
            return lst;
        //     return [iD + 2*(&+p_1): p_1 in Subsets(Seqset(place_lst[1]),r_1)];
        elif rmr1 eq 2 then
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            divs := iD;
            for p_2 in place_lst[2] do
                for plset1 in S1 do
                    divs +:= p_2;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst,divs);
                    divs := iD;
                end for;
            end for;
            return lst;
            // return [iD + 2*(&+p_1 + p_2): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in place_lst[2]];
        elif rmr1 eq 3 then
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst := [];
            divs := iD;
            for p_3 in place_lst[2] do
                for plset1 in S1 do
                    divs +:= p_3;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst,divs);
                    divs := iD;
                end for;
            end for;
            return lst;
            // return [iD + 2*(&+p_1 + p_3): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_3 in place_lst[2]];
        elif rmr1 eq 4 then
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst1 := [];
            divs := iD;
            for p_4 in place_lst[3] do
                for plset1 in S1 do
                    divs +:= p_4;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst1,divs);
                    divs := iD;
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
            // return [iD + 2*(&+p_1 + p_4): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_4 in place_lst[3]] cat [iD + 2*(&+p_1 + &+p_2): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in Subsets(Seqset(place_lst[2]),2)];
        elif rmr1 eq 5 then
            S1 := Multisets(Seqset(place_lst[1]),r_1);
            lst1 := [];
            divs := iD;
            for p_5 in place_lst[4] do
                for plset1 in S1 do
                    divs +:= p_5;
                    for p_1 in plset1 do
                        divs +:= p_1;
                    end for;
                    divs := 2*divs;
                    Append(~lst1,divs);
                    divs := iD;
                end for;
            end for;

            lst2 := [];
            for p_2 in place_lst[2] do
                for p_3 in place_lst[3] do
                    for plset1 in S1 do
                        divs +:= p_2 + p_3;
                        for p_1 in plset1 do
                            divs +:= p_1;
                        end for;
                        divs := 2*divs;
                        Append(~lst2,divs);
                        divs := iD;
                    end for;
                end for;
            end for;
            return lst1 cat lst2; 
            // return [iD + 2*(&+p_1 + p_5): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_5 in place_lst[4]] cat [iD + 2*(&+p_1 + p_2 + p_3): p_1 in Subsets(Seqset(place_lst[1]),r_1), p_2 in place_lst[2],p_3 in place_lst[3]];
        end if;
    elif r_1 eq 0 then
        if rmr1 eq 2 then
            return [iD + 2*(p_2): p_2 in place_lst[2]];
        elif rmr1 eq 3 then
            return [iD + 2*(p_3): p_3 in place_lst[2]];
        elif rmr1 eq 4 then

            S2 := Multisets(Seqset(place_lst[2]),2);
            lst := [];
            divs := iD;
            for plset2 in S2 do
                for p_2 in plset2 do
                    divs +:= p_2;
                end for;
                divs := 2*divs;
                Append(~lst,divs);
                divs := iD;
            end for;
            return [iD + 2*(p_4): p_4 in place_lst[3]] cat lst;
            // return [iD + 2*(p_4): p_4 in place_lst[3]] cat [iD + 2*(&+p_2): p_2 in Subsets(Seqset(place_lst[2]),2)];
        elif rmr1 eq 5 then
            return [iD + 2*(p_5): p_5 in place_lst[4]] cat [iD + 2*(p_2 + p_3): p_2 in place_lst[2],p_3 in place_lst[3]];
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
            m := Depth(v);
            U2:= sub<R|[gens[i1] - (Integers()! v[i1])*gens[m] : i1 in [1..#gens]]>;
            U3:= sub<R|[U1, U2]>;
            Ab := AbelianExtension(d,U3);
            F1:= FunctionField(Ab);

           if Genus(F1) eq 6 then
               cpc := ([NumberOfPlacesOfDegreeOneECF(F1,n) : n in [1..6]]);
               pol:=DefiningPolynomial(RationalExtensionRepresentation(F1));;
               fprintf OutputFileName, "%o" cat "\n", pol;
               fprintf OutputFileName, "%o" cat "\n", cpc;
           end if;
        end if;
    end for;
end for;

quit;
