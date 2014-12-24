function beta = kernelRidgeRegression(K,y,lambda)
    [n,m]= size(K);
    beta = inv((lambda * eye(n) + K))*y;
    
