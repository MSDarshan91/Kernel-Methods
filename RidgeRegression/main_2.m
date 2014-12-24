forestFire = importdata('ICS-E4030_forest_fire_dataset.txt');
[m,n] = size(forestFire);
X = forestFire(:,1:12);
y = forestFire(:,13);
X = X ./ norm(X);
y = y ./ norm(y);
k=1;
lambda = 0.5;
training_set = randperm(345);
test_set = randperm(m-345);
sigma = 0.0001;
error = 1:50;
for lambda = 0.1:0.1:5.1
   K = kernelGram(X(training_set,:),X(training_set,:),'gaussian',sigma);
   beta = kernelRidgeRegression(K,y(training_set),lambda);
   test_K =  kernelGram(X(training_set,:),X(test_set,:),'gaussian',sigma);
   pred = test_K' * beta;
   MSE = (1/(m-345))* sum((pred - y(test_set)).^2);
   error(k) = MSE;
   k = k+1; 
end
plot(error);

lambda = 0.2;
error = 1:50;
for sigma = 0.0001 : 0.00001 : 0.0005
  K = kernelGram(X(training_set,:),X(training_set,:),'gaussian',1);
  beta = kernelRidgeRegression(K,y(training_set),0.5);
  test_K =  kernelGram(X(training_set,:),X(test_set,:),'gaussian',1);
  pred = test_K' * beta;
  MSE = (1/(m-345))* sum((pred - y(test_set)).^2);
end
plot(error);
