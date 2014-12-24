function [count] = Trie_fast(l_s,l_t,depth,count,p,list_index)
if(depth == p)
        count = count+ length(l_s{list_index})*length(l_t{list_index});
        return;
else
    p = p+1;
    len_s = length(l_s{list_index});
    len_t = length(l_t{list_index});
    for i =1:len_s
      temp = list_index*150 + l_s{list_index}{i}(p);
      if temp > length(l_s)
          l_s{temp}{1} = l_s{list_index}{i};
      else
          l_s{temp}{length(l_s{temp})+1} = l_s{list_index}{i};
      end
    end
    for i =1:len_t
      temp = list_index*150 + l_t{list_index}{i}(p);
      if temp > length(l_t)
          l_t{temp}{1} = l_t{list_index}{i};
      else
          l_t{temp}{length(l_t{temp})+1} = l_t{list_index}{i};
      end
    end
    sigma = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '};
    for a = 1:length(sigma)
        temp = list_index*150+sigma{a};
        if ~((temp > length(l_t)) || (temp > length(l_s)))
            if(~((isempty(l_t{temp}))|| (isempty(l_s{temp}))))
                count = Trie_fast(l_s,l_t,depth,count,p,temp);
            end
        end
    end
 end
end
