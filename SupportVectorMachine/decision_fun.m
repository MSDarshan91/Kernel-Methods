function f  = decision_fun(K,c )
     f = c'*K;
     for i = 1:length(f)
           if( f(i) > 0)
               f(i) = +1;
           else
               f(i) = -1;
           end
    end
end

