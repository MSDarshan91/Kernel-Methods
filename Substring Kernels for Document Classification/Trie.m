function [count] = Trie(l_s,l_t,depth,count,p)
if(depth == p)
        count = count+ length(l_s)*length(l_t);
        return;
else
         p = p+1;
            sigma = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '};
            for a = 1:length(sigma)
                % disp(p)
                clear n_l_s;
                clear n_l_t;
                n_l_s = {};
                n_l_t = {};
                len_s = length(l_s);
                len_t = length(l_t);
                 j=1;
                    for i =1:len_s
                        if(strcmp(l_s{i}(p), sigma(a)))
                            n_l_s{j}=l_s{i};
                            j= j+1;
                        end
                    end
                    j=1;
                    for i =1:len_t
                        if(strcmp(l_t{i}(p),sigma(a)))
                            n_l_t{j}=l_t{i};
                            j= j+1;
                        end
                    end
                    if(~(length(n_l_s)==0||length(n_l_t)==0))
                        count = Trie(n_l_s,n_l_t,depth,count,p);
                    end
             end
        end
end
