function res = squareseq(n)
    C = zeros(1,n);
    S = 0;

    for i=1:n
        C(i) = i^2;
        S = C(i)+S;
    end

    res = S;
end
