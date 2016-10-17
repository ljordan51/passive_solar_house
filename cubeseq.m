function res = cubeseq(n)
    C = zeros(1,n);

    for i=1:n
        C(i) = i^3;
    end

    res = C;
end