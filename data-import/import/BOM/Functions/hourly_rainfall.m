% Bit of code to calculate hourly rainfall from cumulative data at 9 am

met.RAIN_cum = met.Rain_9am(tt);
nn = 1;
    while  nn > 0.5
        nn = find (isnan(met.RAIN_cum));
        met.RAIN_cum(nn) = met.RAIN_cum(nn+1);
    end

% 



all_days = unique(floor(met.Date_1));
inc = 1;
met.RAIN_inc = [];
for i = 1:length(all_days)
    ss = find(floor(met.Date_1) == all_days(i));
    %     if isempty(ss)
    
    dump_time = round(0.375*1000) / 1000;
    fix_time = round((21/24)*1000) / 1000;
    for j = 1:length(ss)
        
        actual_time = round((met.Date_1(ss(j)) - floor(met.Date_1(ss(j))))*1000)/1000;
        if ss(j) == 1
            met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j));
        else
            if dump_time == actual_time
                
                met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j));
                
            else
                if fix_time == actual_time % Not changing the calculation but the actual data in the mat file
                    met.RAIN_cum(ss(j)) = met.RAIN_cum(ss(j)); %******
                end
                if j == 1
                    met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j)) - met.RAIN_cum(ss(j)-1);
                else
                    met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j)) - met.RAIN_cum(ss(j-1));
                end
            end
        end
        inc = inc + 1;
    end
    %     end
end

for i = 2:length(met.RAIN_inc)-1
    if met.RAIN_inc(i) == 0 & met.RAIN_inc(i-1) == (-1*(met.RAIN_inc(i+1)))
        met.RAIN_inc(i+1) = met.RAIN_inc(i);
        met.RAIN_inc(i-1) = met.RAIN_inc(i);
    elseif met.RAIN_inc(i) ~= 0 & met.RAIN_inc(i) == (-1*(met.RAIN_inc(i+1)))
        met.RAIN_inc(i) = 0;
        met.RAIN_inc(i+1) = 0;
    elseif met.RAIN_inc(i) < 0 & met.RAIN_cum(i) == 0
        met.RAIN_inc(i) = 0;
    elseif met.RAIN_inc(i) == met.RAIN_cum(i) & met.RAIN_inc(i+2) < 0
        met.RAIN_inc(i) = met.RAIN_cum(i) - met.RAIN_cum(i-1);
        met.RAIN_inc(i+1) = met.RAIN_cum(i+1) - met.RAIN_cum(i);
        met.RAIN_inc(i+2) = met.RAIN_cum(i+2);
    elseif met.RAIN_inc(i) == met.RAIN_cum(i) & met.RAIN_inc(i+1) < 0
        met.RAIN_inc(i) = met.RAIN_cum(i) - met.RAIN_cum(i-1);
        met.RAIN_inc(i+1) = met.RAIN_cum(i+1);
    elseif met.RAIN_inc(i) < 0
        met.RAIN_inc(i) = 0;
    end

end