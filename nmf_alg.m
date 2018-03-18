function errs = nmf_alg(trainingGs,trainingYs,testingGs,testingYs,W,varargin)

[alg,seedrep,nrep,verb] = parse_opt(varargin, 'alg', @process, ...
                                              'seedrep', false,'nrep',10,'verb', 1);

% only worry about rep-related stuff if we're doing more than 1 rep
if nrep > 1
    % if not seed-based reps, make some space to hold the results
    if ~seedrep
        cargout = cell(nrep,1);
    end
    
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
    
    if ~seedrep
        errs = cargout{ndx(1)};        
        % display final error if asked
        if verb >= 1
            disp(['nmf_alg: final errs=' num2str(errs)]);
        end
            
        return;
    else
        % recompute the run with the lowest error norm
        rng(ndx(1));
    end
end

% run the algorithm being used
errs = alg(trainingGs,trainingYs,testingGs,testingYs,W,varargin{:});

% display final error if asked
if verb >= 1
            disp(['nmf_alg: final errs=' num2str(errs)]);
end