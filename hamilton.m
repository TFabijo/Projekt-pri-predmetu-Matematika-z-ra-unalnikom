function [max_path, max_length] = hamilton(G, k, t)
    max_length = -Inf;
    max_path = [];
    gr = graph(G);
    n = numnodes(gr);
    nodes = 1:n;
    
    for iter = 1:(t * factorial(k))
        % Step 1.1:naključno izberemo permutacijo vozlisc
        perm = nodes(randperm(n));
        
        % Step 1.2:konstruiramo graf G^π
        G_perm = permuteGraph(G, perm);
        
        % Step 1.3: klicemo funkcijo longest_k_path za najdalso k-pot v G^π
        try
            [path, length] = longest_k_path(G_perm, k);
        catch
            continue
        end
        
        % najdemo najdalo pot
        if length == k-1
            max_length = length;
            max_path = perm(path);% vrnemo nazaj v originalne vozlisca
            break
        end
    end
    
    % Step 2: pogledamo ce smo nasli k pot
    if max_length == -Inf
        disp('No k-path found.')
    end

    max_path
    max_length
end