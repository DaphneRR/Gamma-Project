function stdshadeJB(amatrix, alpha,acolor,F,smth, astd)


% !!! JB: amatrix: data, alpha: transparency (good values between 0.2 -
% !!! JB: 0.1). F :xvector, smth if mean to be smoothed
% !!! astd : input : 2 lines
% usage: stdshading(amatrix,alpha,acolor,F,smth)
% plot mean and sem/std coming from a matrix of data, at which each row is an
% observation. sem/std is shown as shading.
% - acolor defines the used color (default is red)
% - F assignes the used x axis (default is steps of 1).
% - alpha defines transparency of the shading (default is no shading and black mean line)
% - smth defines the smoothing factor (default is no smooth)
% smusall 2010/4/23

if exist('astd', 'var') && ~isempty(astd)
    whichshade = 'provided';
else whichshade = 'std';
end

if exist('acolor','var')==0 || isempty(acolor)
    acolor='r';
end

if exist('F','var')==0 || isempty(F);
    F=1:size(amatrix,2);
end

if exist('smth','var'); if isempty(smth); smth=1; end
else smth=1;
end

if ne(size(F,1),1)
    F=F';
end


switch whichshade
    case 'provided'
        amean = amatrix;
        fill([F fliplr(F)],[amean+astd(1,:) fliplr(amean-astd(2,:))],acolor,'linestyle','none', 'FaceAlpha', alpha);  % JB
%         fill([F fliplr(F)],[astd(1,:) fliplr(astd(2,:))],acolor, 'FaceAlpha', alpha,'linestyle','none'); % orig
    case 'std'
        amean=smooth(nanmean(amatrix),smth)';
        astd = nanstd(amatrix); % to get std shading
        if exist('alpha','var')==0 || isempty(alpha)
            %     fill([F fliplr(F)],[amean+astd fliplr(amean-astd)],acolor,'linestyle','none'); % original line
            fill([F fliplr(F)],[amean+astd(1,:) fliplr(amean-astd(2,:))],acolor,'linestyle','none');  % JB
            acolor='k';
        else fill([F fliplr(F)],[amean+astd fliplr(amean-astd)],acolor, 'FaceAlpha', alpha,'linestyle','none');  % original
        end
    case 'sem'
        % astd=nanstd(amatrix)/sqrt(size(amatrix,1)); % to get sem shading
end




if ishold==0
    check=true; else check=false;
end

hold on;
plot(F,amean,'color', acolor,'linewidth',1.5); %% change color or linewidth to adjust mean line

if check
    hold off;
end

end



