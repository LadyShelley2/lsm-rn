function [G,Y]=preProcess(filename)
    G=load(['.\data\' num2str(filename) 'out.txt']);
    Y = zeros(size(G));
    Y(find(G>0))=1;
end