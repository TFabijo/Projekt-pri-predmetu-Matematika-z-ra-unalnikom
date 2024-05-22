function [max_path, max_length] = longest_k_path(graph, k)
    % ustvarimo usmerjen graf
    G = digraph(graph);
    
    % s funkcijo toposort topološko uredimo graf
    order = toposort(G);
    
    % število oglišč
    n = numel(order);
    
    % V matriki W skranjujemo najdaljšo pot do vozlišča vij V X pa
    %shranimo vozlišče, iz katerega smo pričli do najdaljše poti v točki
    %vij
    W = zeros(n, k);
    X = cell(n, k);
    X(:,:) = {'*'};% Initialize with '*'
    
    % nastavimo začetne vrednost v matriki na -inf
    for i = 2:n
        for h = 2:k
            W(i,h) = -Inf;
        end
    end
    
    % izračun vredosti za matriko W in X
    for i = 1:n
        for j = i+1:n
            if any(successors(G, order(i)) == order(j)) % prevemrimo ali obstaja povezava
                for h = 1:k-1
                    if W(i, h) ~= -Inf && W(i, h) + graph(order(i), order(j)) > W(j, h+1)
                        W(j, h+1) = W(i, h) + graph(order(i), order(j));
                        X{j, h+1} = i;
                    end
                end
            end
        end
    end
    
    % določitev najdaljše dolžine poti
    [max_length, index] = max(W(:, k));
    if max_length == -Inf
        max_path = [] ;% k-pot ne obstaja
        max_length = -Inf;
        return;
    end
    
    last_vertex = order(index);
    max_path = [last_vertex];
    
    % določitev zaporedja vozlišč v najdaljši poti
    for h = k-1:-1:1
        last_vertex = X{index, h+1};
        if last_vertex == '*'
            break
        end
        max_path = [order(last_vertex), max_path];
        index = last_vertex;
    end
end





