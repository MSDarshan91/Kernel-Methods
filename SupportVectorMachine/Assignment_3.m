X = importdata('X_train.txt');
Y = importdata('y_train.txt');
X_test = importdata('X_test.txt');
Y_test = importdata('y_test.txt');
X = X';
n = length(Y);
X_test = X_test';
kernelFunction = 'gaussian';
K = kernelGram(X,X,kernelFunction,10);
K_test = kernelGram(X,X_test,kernelFunction,10);
c = zeros(length(Y),1);
i=1;
n_t = 0.0005;
lambda = 0.01;
no_iterations =10000;
cost =1:no_iterations;
for t = 1 : no_iterations
    i =ceil(rand()*n);
    cost(t) = cost_function(K,Y,lambda,c);
    new_c = gradient(i,K,Y,c,lambda);
    c = c - n_t * new_c; 
end
pred_train = decision_fun(K,c);
accuracy_train = sum(pred_train == Y')/length(Y);
pred_test = decision_fun(K_test,c);
accuracy_test = sum(pred_test == Y_test')/length(Y_test);
fprintf('Test Accuracy =%f, Train Accuracy =%f\n',accuracy_test,accuracy_train);
plot(cost);
figure;
[X,Y] = perfcurve(pred_test,Y_test,'1');
plot(X,Y);


