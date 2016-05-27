function X = linkC(S,X,n,m)
% Possibly input argument S is redundant (it's just the second column of X)
% and n and m will be defined everywhere Clink is used, so are possibly
% also redundant.
while or(isequal(X(:,end),S) == false,length(X) == 2)
% We want to continue until the last column is the starting value EXCEPT 
% if the last column is also the first column (not equal to the first
% column but ACTUALLY the first column)
% xi = X(1,end);
% yi = X(2,end);
% xi_1 = X(1,end-1); % `end-1' means `second to last'
% yi_1 = X(2,end-1); % need to keep redefining these.
% Those would be handy for notation, but they need to be active.
% p is the 'visiting matrix' that tells you which conditionals you have visited
    if X(1,end) == 0
        if X(1,end-1) == X(2,end) && X(2,end-1) == 0 % because one of the new points is the point last
            % visited
            X = [X,[2*n-X(2,end);2*n]]; %p = [p,1]
        else
            X = [X,[X(2,end);0]]; %p = [p,2];
        end
    elseif X(1,end) == 2*m
        if X(1,end-1) == 2*m-X(2,end) && X(2,end-1) == 0
            X = [X,[2*m-(2*n-X(2,end));2*n]]; %p = [p,3]
        else
            X = [X,[2*m-X(2,end);0]]; %p = [p,4]
        end
    elseif X(2,end) == 0
        if X(1,end) < 2*n && 2*m < X(1,end)+2*n
            if X(1,end-1) == 0 && X(2,end-1) == X(1,end)
                X = [X,[2*m;2*m-X(1,end)]]; %p = [p,5]
            else
                X = [X,[0;X(1,end)]]; %p = [p,6]
            end
        elseif X(1,end) < 2*n && 2*m > X(1,end)+2*n
            if X(1,end-1) == 0 && X(2,end-1) == X(1,end)
                X = [X,[X(1,end)+2*n;2*n]]; %p = [p,7]
            else
                X = [X,[0;X(1,end)]]; %p = [p,8]
            end
        elseif X(1,end) > 2*n && 2*m < X(1,end)+2*n
            if X(1,end-1) == X(1,end)-2*n && X(2,end-1) == 2*n
                X = [X,[2*m;2*m-X(1,end)]];  %p = [p,9]
            else
                X = [X,[X(1,end)-2*n;2*n]]; %p = [p,10]
            end
        else
            if X(1,end-1) == X(1,end)-2*n && X(2,end-1) == 2*n
                X = [X,[X(1,end)+2*n;2*n]]; %p = [p,11]
            else
                X = [X,[X(1,end)-2*n;2*n]]; %p = [p,12]
            end
        end
    else
        if X(1,end) < 2*n && 2*m < X(1,end)+2*n
            if X(1,end-1) == 0 && X(2,end-1) == 2*n-X(1,end)
                X = [X,[2*m;2*n-(2*m-X(1,end))]]; %p = [p,13]
            else
                X = [X,[0;2*n-X(1,end)]]; %p = [p,14]
            end
        elseif X(1,end) < 2*n && 2*m > X(1,end)+2*n
            if X(1,end-1) == 0 && X(2,end-1) == 2*n-X(1,end)
                X = [X,[X(1,end)+2*n;0]]; %p = [p,15]
            else
                X = [X,[0;2*n-X(1,end)]]; %p = [p,16]
            end
        elseif X(1,end) > 2*n && 2*m < X(1,end)+2*n
            if X(1,end-1) == X(1,end)-2*n && X(2,end-1) == 0
                X = [X,[2*m;2*n-(2*m-X(1,end))]]; %p = [p,17]
            else
                X = [X,[X(1,end)-2*n;0]]; %p = [p,18]
            end
        else
            if X(1,end-1) == X(1,end)-2*n && X(2,end-1) == 0
                X = [X,[X(1,end)+2*n;0]]; %p = [p,19]
            else
                X = [X,[X(1,end)-2*n;0]]; %p = [p,20]
            end
        end
    end
    %X
    % pause(2)
    % (Useful for debugging)
end
saveX = X;
% X(:,end+1) = X(:,1);
% link_1 = plot(X(1,:),X(2,:),'.-','markersize',18,'linewidth',2);
hold on
X = saveX;
end