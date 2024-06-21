function rf=r_2layers(obsData, simData)

% Syntax:
%     [error_RMS] = r(obsDATA, simDATA)
%
%
% where:
%     obsData = N x 2
%     simData = N x 2
%
%     obsData(:,1) = time observed
%     obsData(:,2) = Observed Data
%     simData(:,1) = time simulated
%     simData(:,2) = Simulated data
%
% find matching time values
 MatchedData = [simData*0 obsData simData];
ss = find(~isnan(MatchedData(:,2)) == 1);

% I'm not familiar with how MATLAB is optimized to clear it's memory,
% this next call may or may not speed things up.
clear v loc_obs loc_sim

%ss = find(~isnan(MatchedData(:,1)) == 1);

R = corrcoef(MatchedData(ss,2), MatchedData(ss,3));hold on;
[A] = size(R);
if A(2) > 1
	rf=R(1,2);
else
	rf(1,1:2) = NaN;
end

