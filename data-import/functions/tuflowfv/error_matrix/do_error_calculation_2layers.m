
function [stat_mae,stat_r,stat_rms,stat_nash,stat_nmae,stat_nrms]=do_error_calculation_2layers(obsData,simData)

if length(obsData)>6
    disp('doing errors here');
    
    stat_mae=mae_2layers(obsData,simData);
    stat_r  =r_2layers(obsData,simData);
    stat_rms=rms_2layers(obsData,simData);
    stat_nash=nashsutcliffe_2layers(obsData,simData);
    stat_nmae=nmae_2layers(obsData,simData);
    stat_nrms=nrms_2layers(obsData,simData);
else
    disp('too few data to do statistics');
    %clear final_sitename finalname_p obsData simData MatchedData
end

end