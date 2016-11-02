function draw_cm(mat)
%%
%  ??? ??  shamoxia.com
%  ???mat-???tick-?????????label?????{'label_1','label_2'...}
%
%%
imagesc(mat);            %# ????
%colormap(flipud(gray));  %# ?????????value???????value????
num_class=size(mat,1);
 
textStrings = num2str(mat(:),'%0.2f');
textStrings = strtrim(cellstr(textStrings));
[x,y] = meshgrid(1:num_class);
%hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));
textColors = repmat(mat(:) > midValue,1,3);
%??test??????cell?????
%set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors
 
%set(gca,'xticklabel',tick,'XAxisLocation','top');
%rotateXLabels(gca, 45 );
 
%set(gca,'yticklabel',tick);