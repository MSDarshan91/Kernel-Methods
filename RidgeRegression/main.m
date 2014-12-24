forestFire = importdata('ICS-E4030_forest_fire_dataset.txt');
[m,n] = size(forestFire);
X = forestFire(:,1:12);
y = forestFire(:,13);
X = X ./ norm(X); 
y = y ./ norm(y);
error = 0;
k=10;
lambda = 0.5;
sigma = 0.5;
Indices = crossvalind('Kfold', m , 10);
min_lambda = 0.1;
min_sigma = 0.0001;
min_error = 999999999;
for lambda = 0.1:0.1:2.1
    for sigma = 0.0001 : 0.00001 : 0.0002
        for fold = 1 : k
            training_set = find(Indices ~= fold);
            test_set = find(Indices == fold);
            K = kernelGram(X(training_set,:),X(training_set,:),'gaussian',sigma);
            beta = kernelRidgeRegression(K,y(training_set),lambda);
            test_K =  kernelGram(X(training_set,:),X(test_set,:),'gaussian',sigma);
            pred = test_K' * beta;
            MSE = (1/(length(test_set)))* sum((pred - y(test_set)).^2);
            disp(MSE);
            error = (MSE+error);
        end
        error = error/k ;
        if(error < min_error)
            min_lambda = lambda;
            min_sigma = sigma;
            min_error = error;
        end
        disp(error);
    end
end
disp(min_lambda);
disp(min_sigma);
disp(min_error);


