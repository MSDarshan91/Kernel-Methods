function kernelGramMatrix = kernelGram(X1,X2,kernel_type,parameter)
c = 1;
[n1 p1] = size(X1);
[n2 p2] = size(X2);
kernelGramMatrix = ones(n1,n2);
switch kernel_type  
    case 'linear'
        kernelGramMatrix = X1*X2';
    case 'polynomial'
        kernelGramMatrix =  ((X1*X2') + c ).^ parameter;
    case 'gaussian'
    for i = 1:n1
        for j = 1:n2
            kernelGramMatrix(i,j) = exp((-(X1(i,:) - X2(j,:))*(X1(i,:) - X2(j,:))')/(2*(parameter^2)));
        end
    end
end
    
                  
    
    
    