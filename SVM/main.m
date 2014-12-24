clc; clear;close all
data = importdata('ICS-E4030_svm_inputs.txt.txt');
data_output = importdata('ICS-E4030_svm_outputs.txt.txt');
gscatter(data(:,1),data(:,2),data_output)
training_set = 1:600;
test_set = 601:900;
X = data(training_set,:);
Y = data_output(training_set,:);
newX = data(test_set,:);
newY = data_output(test_set,:);
n = 10;
accuracy_train = 1:n;
accuracy_test = 1:n;
KernelFunction = 'gaussian'; % Change the kernel to linear, polynomial or gaussian
d = 0.02; % Step size of the grid
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)]; % the grid
    for i=1:n
        SVMModel = fitcsvm(X,Y,'KernelScale','auto','KernelFunction',KernelFunction,'BoxConstraint',exp(i));
        [~,scores] = predict(SVMModel,xGrid);
        hold all
        contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0]);
        hold off
        [label_train,~] = predict(SVMModel,X);
        accuracy_train(i) = sum(label_train == Y)*100/length(Y);
        [label_test,~] = predict(SVMModel,newX);
        accuracy_test(i) = sum(label_test == newY)*100/length(newY);
        fprintf('BoxConstraint=%f, Training Accuracy = %f, Testing Accuracy = %f\n',exp(i),accuracy_train(i),accuracy_test(i));
    end 
    c=find(max(accuracy_test)==accuracy_test);
    fprintf('The testing accuracy is maximum for BoxConstraint C = %f\n',exp(c));
figure;
plot(exp(1:n),accuracy_train,exp(1:n),accuracy_test);
title(['Training and Test Accuracy vs C for ' KernelFunction ' kernel']);
xlabel('Box Constraint C');
ylabel('Accuracy in %');
legend('Training Accuracy','Test Accuracy');
