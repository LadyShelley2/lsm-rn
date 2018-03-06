function test_evaluation()
clc;clear;close all;
 prediction = [1,2,3;1,2,3;1,2,0];
 base = [0,2,0;0,2,0;1,1,0];
 maeValue=mae(prediction,base);
 rmseValue=rmse(prediction,base);
 mapeValue=mape(prediction,base);
 nmaeValue=nmae(prediction,base);
end