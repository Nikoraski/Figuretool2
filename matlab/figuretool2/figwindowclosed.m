function figwindowclosed(jAxis,jEventdata,hObject)
global figurestack;
tag=get(hObject,'tag');
figurestack=figurestack(~strcmpi(tag,figurestack(:,1)),:);
delete(hObject);
end