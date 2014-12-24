data = readLines("texts_train1.txt")
Sys.time();
noCommonSub <- function(s,t,p)
{
	len1= nchar(s)
	sub_s = substring(s,1:(len1+p-1),p:len1)
	len2 = nchar(t)
	sub_t = substring(t,1:(len2+p-1),p:len2)
	v1 = table(sub_s)
	v2 = table(sub_t)
	commonVals = intersect(names(v1),names(v2))
	temp = v1[commonVals]*v2[commonVals]
	temp <- temp[!is.na(temp)]
	return(sum(temp))
}
p = 2  # the substring length
Sys.time()
n = length(data)
#For Test kernel
val_data = readLines("texts_val.txt") 
val_len = length(val_data)
K = matrix(0,n,val_len)
for(i in 1:n)
	for(j in 1:val_len)
			K[i,j] = noCommonSub(data[i],val_data[j],p)

Sys.time()
	fileConn<-file("K_val_2.txt")
	write(K,fileConn,sep="\n")
	close(fileConn)
