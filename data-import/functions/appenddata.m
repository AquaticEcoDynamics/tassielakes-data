function outdata = appenddata(mdate,thestring)
 %thestring   
if isnumeric(thestring)
    outdata(1:length(mdate),1) = thestring;
else
    outdata = {};
    outdata(1:length(mdate),1) = {thestring};
end