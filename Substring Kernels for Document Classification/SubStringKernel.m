function [ count ] = SubStringKernel(s,t,depth)
%SUBSTRINGKERNEL Summary of this function goes here
%   Detailed explanation goes here
    [m] = length(s);
    [n] = length(t);
    for i=1:(m-depth+1)
        l_s_e{i} = s(i:(i+depth-1)); 
        %l_s_e{1}{i} = s(i:(i+depth-1)); 
    end
    for i=1:(n-depth+1)
        l_t_e{i} = t(i:(i+depth-1)); 
        %l_t_e{1}{i} = t(i:(i+depth-1));
    end
    count =0;
    count = Trie(l_s_e,l_t_e,depth,count,0);
    %count = Trie_fast(l_s_e,l_t_e,depth,count,0,1);
end
