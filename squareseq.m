function res = squareseq(n)
    C = zeros(1,n);

    for i=1:n
        C(i) = i^2;
    end

    res = C;
end
