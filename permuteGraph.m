function G_perm = permuteGraph(G, perm)
    % sedanja matrika grafa
    adj_matrix = G;
    
    % permutiramo matriko grafa
    adj_matrix_perm = adj_matrix(perm, perm);

    % naredimo aciklični graf
    adj_matrix_perm(tril(true(size(adj_matrix_perm)))) = 0;
    
    % naša nova permutirana matrika grafa
    G_perm = adj_matrix_perm;
end