function figfocusgained(jAxis,jEventdata,hObject)
global figurestack;
tag=get(hObject,'tag');
figurestack=[figurestack(~strcmpi(tag,figurestack(:,1)),:);figurestack(strcmpi(tag,figurestack(:,1)),:)];
end

