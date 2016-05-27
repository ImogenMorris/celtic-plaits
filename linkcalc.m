function [current_X,prev_X,tv] = linkcalc(current_X,prev_X,n,m)

saveX = [current_X,prev_X];
tf = saveX(2,:) == 0; % Creates a logical array 'true' where the 'y' row of X
% is zero
ind = find(tf == 1);
%if ~isempty(ind)
Y = zeros(1,m);
for i = 1:length(ind)
    x  = saveX(1,ind(i));
    fx = (x+1)/2;
    Y(fx) = 1;
end
% Will this size of grid give a link? and where shall we start next?
X = current_X;
if any(Y==0)
    tv = 1;
    yind = find(Y == 0);
    xcoor = 2*yind(1)-1; % ycoor = 0
    S = [xcoor;0];
    X = S;
    if X(1,end) == 0
        X = [X,[2*n-X(2,end);2*n]]; %p = [p,1]
    elseif X(1,end) == 2*m
        X = [X,[2*m-(2*n-X(2,end));2*n]]; %p = [p,3]
    elseif X(2,end) == 0
        if X(1,end) < 2*n && 2*m < X(1,end)+2*n
            X = [X,[0;X(1,end)]]; %p = [p,6]
        elseif X(1,end) < 2*n && 2*m > X(1,end)+2*n
            X = [X,[0;X(1,end)]]; %p = [p,8]
        elseif X(1,end) > 2*n && 2*m < X(1,end)+2*n
            X = [X,[X(1,end)-2*n;2*n]]; %p = [p,10]
        else
            X = [X,[X(1,end)-2*n;2*n]]; %p = [p,12]
        end
    else
        if X(1,end) < 2*n && 2*m < X(1,end)+2*n
            X = [X,[0;2*n-X(1,end)]]; %p = [p,14]
        elseif X(1,end) < 2*n && 2*m > X(1,end)+2*n
            X = [X,[0;2*n-X(1,end)]]; %p = [p,16]
        elseif X(1,end) > 2*n && 2*m < X(1,end)+2*n
            X = [X,[X(1,end)-2*n;0]]; %p = [p,18]
        else
            X = [X,[X(1,end)-2*n;0]]; %p = [p,20]
        end
    end
    p = [];
    current_X = linkC(S,X,n,m);
    prev_X = saveX;
    
else
    tv = 0;
    
end