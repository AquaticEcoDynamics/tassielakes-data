load matfiles\hawkesbury.mat

vars = [];

sites = fieldnames(hawkesbury);

for i = 1:length(sites)
    v = fieldnames(hawkesbury.(sites{i}));
    vars = [vars;v];
end

unique(vars)