function [err]=evaluation2(prediction,base)
    err = mape(prediction,base);
end