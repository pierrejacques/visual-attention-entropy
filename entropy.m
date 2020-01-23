
function output = entropy(map)
    vec = map(:);
    output = 0;
    if sum(vec) > 0
        p = vec./sum(vec);
        p(p==0) = [];
        output = -sum(p.*log(p)/log(2));
    end
end
