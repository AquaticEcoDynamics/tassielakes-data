% Error calculation:
% 3) ROOT MEAN SQUARE (RMS)


% RMS =  sqrt{sum[( Xsim - Xobs ).^2]}


% Syntax:
%     [error_RMS] = mae(obsDATA, simDATA)
%
% where:
% where:
%     obsData = N x 2
%     simData = N x 2
%
%     obsData(:,1) = time observed
%     obsData(:,2) = Observed Data
%     simData(:,1) = time simulated
%     simData(:,2) = Simulated data
%
function [error_RMS] = rms_2layers(obsData, simData)

 MatchedData = [simData*0 obsData simData];
ss = find(~isnan(MatchedData(:,2)) == 1);
X = MatchedData(ss,2) - MatchedData(ss,3);

error_RMS =  sqrt(sum(X.^2)/length(X));