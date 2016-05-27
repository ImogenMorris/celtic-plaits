function Cplaitgui(n,m)
% CPLAITGUI displays the Celtic plait for the 2nx2m grid, highlighting link
% components in different colours.
% The menu in the interface allows the user to add and remove the link
% components seperately.
% Helper functions are firstlink, linkcalc and linkC.

if n > m
    saven = n;
    n = m;
    m = saven;
else
    n = n;
end

% Sets units to pixels
set(0,'units','pixels')
% Obtains screen size in pixels
pix_ss = get(0,'screensize');

% Figure dimensions
fig_w = 1200;
fig_h = 700;

% Position set to open centrally
% Visibility is to 'off' until the basic UI stuff is set up.
f = figure('Visible','off','Position',[(pix_ss(3)-fig_w)/2,...
    (pix_ss(4)-fig_h)/2,fig_w,fig_h]);

%  Construct the components

% Button dimensions
bton_w = 100;
bton_h = 40;

addi = uicontrol('Style','pushbutton',...
    'String','Add Link','Position',[4*fig_w/5,7*fig_h/10,bton_w,bton_h],...
    'Callback',{@addbutton_Callback}); % why 7 not 6? confused.

remi = uicontrol('Style','pushbutton',...
    'String','Remove Last Link','Position',[4*fig_w/5,5*fig_h/10,bton_w,bton_h],...
    'Callback',{@rembutton_Callback});

counti = uicontrol('Style','pushbutton',...
    'String','Count Links','Position',[4*fig_w/5,4*fig_h/10,bton_w,bton_h],...
    'Callback',{@countbutton_Callback});

texti = uicontrol('Style','text','String','','Position',...
    [4*fig_w/5,3*fig_h/10,2*bton_w,bton_h]);

% Axes
ai = axes('Units','pixels','Position',[fig_w/10,fig_h/10,fig_w/1.5,...
    5*fig_h/6]);

% Aligns all components (except axes) along their centres

align([addi,remi,counti,texti],'Center','None');

%  Initialization tasks
% Change units to normalized so components resize automatically.
f.Units = 'normalized';
ai.Units = 'normalized';
addi.Units = 'normalized';


% Create a plot in the axes.
[current_X,tv] = firstlink(n,m); % (turquoise because variable spans multiple 
% functions)
current_X = current_X(:,(1:end-2));
howmany = length(current_X);
current_X(:,end+1) = current_X(:,1);
p = plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
    'linewidth',2);
hold on;

if tv == 2
    set(texti,'String',...
        'This size of grid contains multiple link components');
    if m >= 5*n
        set(texti,'String',...
            'Wow, this is a long one! This size of grid contains multiple link components.');
    end
    
else 
    set(texti,'String','This size of grid contains a knot');
    if m >= 5*n
        set(texti,'String',...
            'Wow, this is a long one! This size of grid contains a knot.');
    end
end

tv = 1;

% Button count
% initialize the counter for number of times pressed for addbutton
addbuttonPressCount = 0;
rembuttonPressCount = 0;

prev_X = current_X;

while tv == 1
    
    [current_X,prev_X,tv] = linkcalc(current_X,prev_X,n,m);
    % plot current link
    current_X(:,end+1) = current_X(:,1);
    plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
        'linewidth',2);
    
        addbuttonPressCount = addbuttonPressCount + 1;  
end 

truelinknum = addbuttonPressCount-rembuttonPressCount;

% Assign a name to appear in the window title.
f.Name = 'Celtic Plait GUI';

% Move the window to the center of the screen.
movegui(f,'center');

% Axes - aesthetic
% Grid part
grid on
ai.XTick = 0:1:2*m;
ai.YTick = 0:1:2*n;
axis tight
pbaspect([2*m 2*n 1]) % To keep it in proportion - check if this does anything

% % Colour
% ai = gca; % current axes
% h = @(x) x/260;
% ai.Color = [h(191) h(239) h(255)]; % RGB colour values out of 0 to 1
% % 1 being the palest.

% Labels
title(['Link Grid for a ',num2str(2*n),' by ',num2str(2*m),' Plait']);


% Make the UI visible
f.Visible = 'on';
p = plot(0);

%  Callbacks
    function addbutton_Callback(source,eventdata)
        
        %         if addbuttonPressCount-rembuttonPressCount == 0
        %             % Create a plot in the axes.
        %             [current_X,tv] = firstlink(n,m); % (turquoise because variable spans multiple
        %             % functions)
        %             current_X(:,end+1) = current_X(:,1);
        %             plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
        %                 'linewidth',2,'color',rand(1,3));
        %             prev_X = current_X;
        %             hold on;
        %             addbuttonPressCount = addbuttonPressCount + 1;
        %         else
        
        if addbuttonPressCount - rembuttonPressCount >= truelinknum
            
            set(texti,'String','All links have been calculated')
        else
            % Create a plot in the axes.
            [current_X,tv] = firstlink(n,m); % (turquoise because variable spans multiple
            % functions)
            current_X = current_X(:,(1:end-2));
            prev_X = current_X;
            current_X(:,end+1) = current_X(:,1);
            hold off
            p = plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
                'linewidth',2);
            hold on;
            % Axes - aesthetic
            % Grid part
            grid on
            ai.XTick = 0:1:2*m;
            ai.YTick = 0:1:2*n;
            axis tight
            pbaspect([2*m 2*n 1]) % To keep it in proportion - check if this does anything
            % Labels
            title(['Link Grid for a ',num2str(2*n),' by ',num2str(2*m),' Plait']);
            addbuttonPressCount = addbuttonPressCount + 1;
            fixcount = addbuttonPressCount - rembuttonPressCount;
            for i = 2:fixcount
                [current_X,prev_X,tv] = linkcalc(current_X,prev_X,n,m);
                % plot current link
                current_X(:,end+1) = current_X(:,1);
                p = plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
                    'linewidth',2);
             
            end
      
        end
        
        %         end
    end


    function rembutton_Callback(source,eventdata)
        %         undo(1) % works but unsatisfactorily since it doesn't let you add
        % them back in.
        
        % This should be exactly the same as addbutton_callback, except it
        % racks up the number of rembuttonPressCount.
        
        if addbuttonPressCount - rembuttonPressCount == 1
            hold off
            delete(p);
            % Axes - aesthetic
            % Grid part
            grid on
            ai.XTick = 0:1:2*m;
            ai.YTick = 0:1:2*n;
            axis tight
            pbaspect([2*m 2*n 1]) % To keep it in proportion - check if this does anything
            % Labels
            title(['Link Grid for a ',num2str(2*n),' by ',num2str(2*m),' Plait']);
            rembuttonPressCount = rembuttonPressCount + 1;
        elseif addbuttonPressCount - rembuttonPressCount == 0
            set(texti,'String','No links to remove.');
        else
            % Create a plot in the axes.
            [current_X,tv] = firstlink(n,m); % (turquoise because variable spans multiple
            % functions)
            current_X = current_X(:,(1:end-2));
            prev_X = current_X;
            current_X(:,end+1) = current_X(:,1);
            hold off
            p = plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
                'linewidth',2);
            hold on;
            % Axes - aesthetic
            % Grid part
            grid on
            ai.XTick = 0:1:2*m;
            ai.YTick = 0:1:2*n;
            axis tight
            pbaspect([2*m 2*n 1]) % To keep it in proportion - check if this does anything
            % Labels
            title(['Link Grid for a ',num2str(2*n),' by ',num2str(2*m),' Plait']);
            rembuttonPressCount = rembuttonPressCount + 1;
            fixcount = addbuttonPressCount - rembuttonPressCount;
            for i = 2:fixcount
                [current_X,prev_X,tv] = linkcalc(current_X,prev_X,n,m);
                % plot current link
                current_X(:,end+1) = current_X(:,1);
                p = plot(current_X(1,:),current_X(2,:),'.-','markersize',18,...
                    'linewidth',2);
            end
        end
    end

    function countbutton_Callback(source,eventdata)
        x = addbuttonPressCount-rembuttonPressCount;
        nolink = ['The number of links is ',num2str(x)];
        set(texti,'String',nolink);
    end


end
