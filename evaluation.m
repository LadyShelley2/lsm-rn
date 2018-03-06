function [err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
    err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=evaluation(prediction,base,average)

[n,n]=size(prediction);

%% mape
err_prediction_mape = mape(prediction,base);
err_average_mape = mape(average,base);

%% mae
err_prediction_mae=mae(prediction,base);
err_average_mae = mae(average,base);

%% rmse
err_prediction_rmse = rmse(prediction,base);
err_average_rmse = rmse(average,base);

%% nmae
err_prediction_nmae = nmae(prediction,base);
err_average_nmae = nmae(average,base);

%% visualization

prediction_element=[];
base_element=[];
average_element=[];

for i=1:n-1;
    prediction_element =[prediction_element,prediction(i+1,i)];
    base_element =[base_element,base(i+1,i)];
    average_element =[average_element,average(i+1,i)];
end

% figure;
% plot(prediction_element);
% hold on;
% plot(base_element,'r');
% hold on;
% plot(average_element,'y');
% legend('Ԥ��ֵ','ʵ��ֵ','ƽ��ֵ');
% xlabel('·�α��') % x-axis label
% ylabel('·���������ֵ') % y-axis label

