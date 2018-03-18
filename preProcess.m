function [G,Y]=preProcess(filename,path)
    G=load([path num2str(filename) 'out.txt']);
    Y = zeros(size(G));
    Y(find(G>0))=1;
end