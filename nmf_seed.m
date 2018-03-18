function index = nmf_seed(trainingGs,trainingYs,testingGs,testingYs,W,varargin)

[alg,seedrep,nrep,verb] = parse_opt(varargin, 'alg', @process, ...
                                              'seedrep', false,'nrep',10,'verb', 1);

dnorm = zeros(1,nrep);

for i = 1:nrep
    % set seed so we can reproduce run
    rng(i);

    % run the algorithm being used
    errs = alg(trainingGs,trainingYs,testingGs,testingYs,W,varargin{:});

    % store this run's results if we're not doing seed-based reps
    if ~seedrep
        cargout{i} = errs;
    end
    dnorm(i) = errs(1);% 将nmae存起来，后面会根据nmae进行排序，选出误差最小的随机数并保存。

    % display rep error if asked
    if verb >= 2
        disp(['nmf_alg: final errs=' num2str(errs)]);
    end
end

% sort error norms
[junk, ndx] = sort(dnorm, 'ascend');

% recompute the run with the lowest error norm
rng(ndx(1));

%result
index = ndx(1);

% run the algorithm being used
errs = alg(trainingGs,trainingYs,testingGs,testingYs,W,varargin{:});

% display final error if asked
if verb >= 1
            disp(['nmf_alg: final errs=' num2str(errs)]);
end