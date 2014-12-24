X = importdata('ICS-E4030_logx.txt');
Y = importdata('ICS-E4030_logy.txt');
training_set = 1:800;
test_set = 801:1000;
scaledX = X;
%Scaling Down the data
scaledX(:,1) = (X(:,1)-mean(X(:,1))) ./ (max(X(:,1)-min(X(:,1))));
scaledX(:,2) = (X(:,2)-mean(X(:,2))) ./ (max(X(:,2)-min(X(:,2))));
K = kernelGram(scaledX(training_set,:),scaledX(training_set,:),'polynomial',10);
K_test = kernelGram(scaledX(training_set,:),scaledX(test_set,:),'polynomial',10);
c = zeros(length(Y(training_set,:)),1);
cmin = zeros(length(Y(training_set,:)),1);
i=1;
n_t = 0.0005;
lambda = 0.001;
no_iterations =10000;
cost =1:no_iterations;
Costmin = 1e10;
for t = 1 : no_iterations
    i = mod(i,800);
    i=i+1;
    cost(t) = cost_function(K,Y(training_set,:),lambda,c);
    new_c = gradient(i,K,Y(training_set,:),c,lambda);
    c = c - n_t * new_c; 
    if(cost(t) < Costmin)
        Costmin = cost(t);
        cmin = c;
    end
end
c = cmin;
fprintf('Final Cost Value = %f',cost(t));
[pred_train,~] = decision_fun(K,c);
accuracy_train = sum(pred_train == Y(training_set,:))/length(Y(training_set,:));
[pred_test,~] = decision_fun(K_test,c);
accuracy_test = sum(pred_test == Y(test_set,:))/length(Y(test_set,:));
plot(1:no_iterations,cost);
xlabel('Iteration Number');
ylabel('Cost Value');
figure;
gscatter(scaledX(:,1),scaledX(:,2),Y);
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(scaledX(:,1)):d:max(scaledX(:,1)), ...
min(scaledX(:,2)):d:max(scaledX(:,2)));
xGrid = [x1Grid(:),x2Grid(:)]; % the grid
K_grid = kernelGram(scaledX(training_set,:),xGrid,'polynomial',10);
[scores,~] = decision_fun(K_grid,c);
hold on
contour(x1Grid,x2Grid,reshape(scores,size(x1Grid)),[0 0]);
% SVM Implementation
% KernelFunction = 'polynomial';
% SVMModel = fitcsvm(scaledX(training_set,:),Y(training_set,:),'KernelScale','auto','PolynomialOrder',3,'Verbose',0,'KernelFunction',KernelFunction,'BoxConstraint',1);
% [train_svm,~] = predict(SVMModel,scaledX(training_set,:));
% accuracy_train_svm = sum(train_svm == Y(training_set,:))/length(Y(training_set,:));
% [test_svm,~] = predict(SVMModel,scaledX(test_set,:));
% accuracy_test_svm = sum(test_svm == Y(test_set,:))/length(Y(test_set,:));
% [~,scores] = predict(SVMModel,xGrid);
% hold on
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k-*');
% fprintf('Test Accuracy Logistic=%f, Test Accuracy SVM=%f\n',accuracy_test,accuracy_train_svm);
