setenv('AWS_ACCESS_KEY_ID', 'C24U05JJZQ15U9Q7LVY2'); 
setenv('AWS_SECRET_ACCESS_KEY', 'psCwJXT1gN0dZS9P1L9HgShf5HemIVP6TBSCKzC5');

fds = fileDatastore('https://projects.pawsey.org.au:443/data-lake/',...
    'FileExtensions',{'.csv', '.xlsx'},...
    'ReadFcn',@open,...
    'IncludeSubfolders',true);
% img = ds.readimage(1);
% imshow(img)