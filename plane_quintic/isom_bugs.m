R<x0,x1,x2> := PolynomialRing(GF(2),3);
X := ProjectiveSpace(R);

eqn_list := [
x0^5 + x0^4*x1 + x1^5 + x0^3*x1*x2 + x1^4*x2 + x0^3*x2^2 + x0*x1^2*x2^2 + x0*x2^4 + x1*x2^4,
x0^5 + x0^4*x1 + x1^5 + x0^4*x2 + x1^4*x2 + x0*x2^4 + x1*x2^4,
x0^5 + x0^2*x1^3 + x1^5 + x0^4*x2 + x1^4*x2 + x0*x2^4 + x1*x2^4,
x0^5 + x0^4*x1 + x0^3*x1^2 + x0^2*x1^3 + x1^5 + x0^4*x2 + x0^3*x1*x2 + x0*x2^4 + x1*x2^4
];

eqn_list_2 := [
x0^5 + x0^4*x1 + x0^3*x1^2 + x0^3*x1*x2 + x0^3*x2^2 + x0*x1^4 + x0*x1^2*x2^2 + x0*x2^4 + x1^5 + x1^4*x2 + x1*x2^4,
x0^5 + x0^4*x2 + x0*x1^4 + x0*x2^4 + x1^5,
x0^5 + x0^4*x1 + x0^4*x2 + x0^2*x1^3 + x0*x1^4 + x0*x2^4 + x1^5 + x1^4*x2 + x1*x2^4,
x0^5 + x0^4*x1 + x0^4*x2 + x0^3*x1*x2 + x0^3*x2^2 + x0^2*x1^3 + x0^2*x1^2*x2 + x0^2*x1*x2^2 + x0^2*x2^3 + x0*x1^4 + x0*x2^4 + x1^5 + x1^4*x2
];

function FFConstruction(fsupp)
    return AlgorithmicFunctionField(FunctionField(Curve(Scheme(X,fsupp))));
end function;

for i in [1..4] do
    F1 := FFConstruction(eqn_list[i]);
    F2 := FFConstruction(eqn_list_2[i]);
    print(IsIsomorphic(F1,F2));
    print(#Isomorphisms(F1,F2));
end for;

quit;