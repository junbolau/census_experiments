/*

find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../curves_by_ramification.m &\n"' > RUN
emacs -nw RUN
add #!/bin/sh
chmod u+x RUN
./RUN

*/

SetMS(false);
OutputFileName := InputFileName;
i := StringToInteger(InputFileName[1]);

P<x,y> := AffineSpace(FiniteField(2),2);
EC_list := [
            (y^2) + y + x^3 + x + 1,
            (y^2) + x*y + y + x^3 + 1,
            (y^2) + y + x^3,
            (y^2) + x*y + x^3 + 1,
            (y^2) + y + x^3 + x
            ];

f := EC_list[i];
E := Curve(P,f);
F0 := AlgorithmicFunctionField(FunctionField(E));
B := Parent(DefiningPolynomial(F0));
A := BaseRing(B);
AssignNames(~A,["x"]);
AssignNames(~B,["y"]);
ID := Identity(DivisorGroup(F0));

RamDivisor := function(r);
    lst := [];
    if r eq 0 then
        return [ID];
    elif r eq 1 then
        return [2*(ID + p1) : p1 in Places(F0,1)];
    elif r eq 2 then
        place_lst := [Places(F0,1),Places(F0,2)];
        S1 := Multisets(Seqset(place_lst[1]),2);
        for plset1 in S1 do
            divs := ID;
            for p_1 in plset1 do
                divs +:= p_1;
            end for;
            Append(~lst,2*divs);
        end for;
        for p_2 in place_lst[2] do
            Append(~lst,2*(ID + p_2));
        end for;
        return lst;
    elif r eq 3 then
        place_lst := [Places(F0,1),Places(F0,2),Places(F0,3)];
        S1 := Multisets(Seqset(place_lst[1]),3);
        for plset1 in S1 do
            divs := ID;
            for p_1 in plset1 do
                divs +:= p_1;
            end for;
            Append(~lst,2*divs);
        end for;
        for p_1 in place_lst[1] do
            for p_2 in place_lst[2] do
                Append(~lst,2*(ID + p_1 + p_2));
            end for;
        end for;
        for p_3 in place_lst[3] do
            Append(~lst,2*(ID + p_3));
        end for;
        return lst;
    elif r eq 4 then
        place_lst := [Places(F0,1),Places(F0,2),Places(F0,3),Places(F0,4)];
        S1 := Multisets(Seqset(place_lst[1]),4);
        for plset1 in S1 do
            divs := ID;
            for p_1 in plset1 do
                divs +:= p_1;
            end for;
            Append(~lst,2*divs);
        end for;
        S1 := Multisets(Seqset(place_lst[1]),2);
        for p_2 in place_lst[2] do
            divs := ID + p_2;
            for plset1 in S1 do
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst,2*divs);
                divs := ID + p_2;
            end for;
        end for;
        for p_1 in place_lst[1] do
            for p_3 in place_lst[3] do
                Append(~lst,2*(ID + p_1 + p_3));
            end for;
        end for;
        S2 := Multisets(Seqset(place_lst[2]),2);
        for plset2 in S2 do
            divs := ID;
            for p_2 in plset2 do
                divs +:= p_2;
            end for;
            Append(~lst,2*divs);
        end for;
        for p_4 in place_lst[4] do
            Append(~lst,2*(ID + p_4));
        end for;
        return lst;
    elif r eq 5 then
        place_lst := [Places(F0,1),Places(F0,2),Places(F0,3),Places(F0,4),Places(F0,5)];
        S1 := Multisets(Seqset(place_lst[1]),5);
        for plset1 in S1 do
            divs := ID;
            for p_1 in plset1 do
                divs +:= p_1;
            end for;
            Append(~lst,2*divs);
        end for;
        S1 := Multisets(Seqset(place_lst[1]),3);
        for p_2 in place_lst[2] do
            divs := ID + p_2;
            for plset1 in S1 do
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst,2*divs);
                divs := ID + p_2;
            end for;
        end for;
        S1 := Multisets(Seqset(place_lst[1]),2);
        for p_3 in place_lst[3] do
            divs := ID + p_3;
            for plset1 in S1 do
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst,2*divs);
                divs := ID + p_3;
            end for;
        end for;
        S2 := Multisets(Seqset(place_lst[2]),2);
        for p_1 in place_lst[1] do
            divs := ID + p_1;
            for plset2 in S2 do
                for p_2 in plset2 do
                    divs +:= p_2;
                end for;
                Append(~lst,2*divs);
                divs := ID + p_1;
            end for;
        end for;
        for p_1 in place_lst[1] do
            for p_4 in place_lst[4] do
                Append(~lst,2*(ID + p_1 + p_4));
            end for;
        end for;
        for p_2 in place_lst[2] do
            for p_3 in place_lst[3] do
                Append(~lst,2*(ID + p_2 + p_3));
            end for;
        end for;
        for p_5 in place_lst[5] do
            Append(~lst,2*(ID + p_5));
        end for;
        return lst;
        
    elif r eq 6 then
        place_lst := [Places(F0,1),Places(F0,2),Places(F0,3),Places(F0,4),Places(F0,5),Places(F0,6)];
        S1 := Multisets(Seqset(place_lst[1]),6);
        for plset1 in S1 do
            divs := ID;
            for p_1 in plset1 do
                divs +:= p_1;
            end for;
            Append(~lst,2*divs);
        end for;
        
        S1 := Multisets(Seqset(place_lst[1]),4);
        for p_2 in place_lst[2] do
            divs := ID + p_2;
            for plset1 in S1 do
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst,2*divs);
                divs := ID + p_2;
            end for;
        end for;
        
        S1 := Multisets(Seqset(place_lst[1]),2);
        S2 := Multisets(Seqset(place_lst[2]),2);
        for plset1 in S1 do
            divs1 := ID;
            for p_1 in plset1 do
                divs1 +:= p_1;
            end for;
            for plset2 in S2 do
                divs := divs1;
                for p_2 in plset2 do
                    divs +:= p_2;
                end for;
                Append(~lst, 2*divs);
            end for;
        end for;
                
        S2 := Multisets(Seqset(place_lst[2]),3);
        for plset2 in S2 do
            divs := ID;
            for p_2 in plset2 do
                divs +:= p_2;
            end for;
            Append(~lst,2*divs);
        end for;
        
        S1 := Multisets(Seqset(place_lst[1]),3);
        for p_3 in place_lst[3] do
            for plset1 in S1 do
                divs := ID + p_3;
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst,2*divs);
            end for;
        end for;
        
        for p_1 in place_lst[1] do
            for p_2 in place_lst[2] do
                for p_3 in place_lst[3] do
                    Append(~lst, 2*(ID + p_1 + p_2 + p_3));
                end for;
            end for;
        end for;
        
        S3 := Multisets(Seqset(place_lst[3]),2);
        for plset3 in S3 do
            divs := ID;
            for p_3 in plset3 do
                divs +:= p_3;
            end for;
            Append(~lst, 2*divs);
        end for;
        
        S1 := Multisets(Seqset(place_lst[1]),2);
        for p_4 in place_lst[4] do
            for plset1 in S1 do
                divs := ID + p_4;
                for p_1 in plset1 do
                    divs +:= p_1;
                end for;
                Append(~lst, 2*divs);
            end for;
        end for;

        for p_2 in place_lst[2] do
            for p_4 in place_lst[4] do
                Append(~lst, 2*(ID + p_2 + p_4));
            end for;
        end for;
        
        for p_5 in place_lst[5] do
            for p_1 in place_lst[1] do
                Append(~lst, 2*(ID + p_1 + p_5));
            end for;
        end for;
        
        for p_6 in place_lst[6] do
            Append(~lst, 2*(ID + p_6));
        end for;
        return lst;
    end if;
end function;




if i eq 4 then
    ini_ind := 157;
    ter_ind := 252;
elif i eq 5 then
    ini_ind := 231;
    ter_ind := 315;
end if;

ram := 6;
ram_divs := RamDivisor(ram);

for d in ram_divs[ini_ind..ter_ind] do
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
            Ab:= AbelianExtension(d,U3);
            F1:= FunctionField(Ab);
            if Genus(F1) eq 7 then
                cpc := [NumberOfPlacesOfDegreeOneECF(F1,n) : n in [1..7]];
                pol:= DefiningPolynomial(RationalExtensionRepresentation(F1));
                fprintf OutputFileName, "[" cat "%o" cat ",[" cat "%o" cat "]]" cat "\n", cpc,pol;
            end if;
        end if;
    end for;
end for;

quit;
