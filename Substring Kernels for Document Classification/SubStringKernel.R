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
K = matrix(0,n,n)
for(i in 1:n)
{
	for(j in 1:i)
		if(i==j)
		{
			K[i,j] = nchar(data[i])+p-1
			K[i,j] = K[i,j]*K[i,j];
		}else{
			K[i,j] = noCommonSub(data[i],data[j],p)
			K[j,i] = K[i,j]
			Sys.time()
		}
	print(i)
}
Sys.time()
	fileConn<-file("K_2.txt")
	write(K,fileConn,sep="\n")
	close(fileConn)
