function i_grad = gradient(i,K,y,c,lambda)

    i_grad = -((y(i)*exp(-y(i)*K(:,i)'*c))/(1+exp(-y(i)*K(:,i)'*c)))*K(:,i) + lambda * K * c;
    
end
