function cost = cost_function(K,y,lambda,c)
    n=length(y);
    new_cost = ones(n,1);
    for i = 1:n
        new_cost(i) = max(0,(1-y(i)*K(:,i)'*c)) ;
    end
    cost = sum(new_cost) + (lambda/2)*c'*K*c;
end