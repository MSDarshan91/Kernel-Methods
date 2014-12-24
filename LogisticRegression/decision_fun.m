function [ sigma,f ] = decision_fun(K,c )
    f = K'*c;
    sigma = ones(size(K,2),1);
    for i = 1:length(sigma)
           if((1/(1+exp(-f(i)))) > 0.5)
               sigma(i) = +1;
           else
               sigma(i) = -1;
           end
    end
end

