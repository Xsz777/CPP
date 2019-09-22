function current = noise()
    current = [normrnd(0, 0.25) normrnd(0, 0.25) normrnd(0, 0.25)];
    if abs(normrnd(0, 1))>1.75 % 0.1336
        current = [normrnd(0, 1) normrnd(0, 1) normrnd(0, 1)];
    end
end

