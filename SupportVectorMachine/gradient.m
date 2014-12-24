function i_grad = gradient(i,K,y,c,lambda)

    if((y(i)*K(:,i)'*c) < 1)
        i_grad = -y(i)*K(:,i) + lambda*K*c;
    else
        i_grad = lambda*K*c;
    end
    
    
end
