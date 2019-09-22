%demo
    C = 10;
    DX = 5;
    detect_radius = 5;
    L = 60;
    H = 20;
    dx = 4;
    work_radius = 2;
    search_radius = 3;
    fps = 10;
    z_submarine =98;
    z_cruising =100;
    max_deceleration = 5;  %减速时的加速度
    transl_spd = 1.5;
    rot_spd = pi;

    Delta_y = 0.5;
    Delta_z = 0.5;
    down_work_radius = 0.5;
    down_transl_spd = 0.1;
    down_transl = 4;
    
    max_distance = 3;

    x_start = 0;
    y_start = 0;

    x_end = x_start;
    y_end = y_start;

    % get polygon
    M = [0 0;L/1.41 0;L/1.41 L/1.41;0 L/1.41];
    Mshifted = [L/1.41 0;L/1.41 L/1.41;0 L/1.41;0 0];


    %----- Optimal coverage path planning -----
    tic;
    % Compute Antipodal pairs
    %A = antipodalPoints(M);
    %[m, ~] = size(A);

%     % Graph polygon and antipodal points
%     figure('Position',[10 100 500 500],'Renderer','zbuffer');
%     axis equal; hold on;
%     line([M(:,1)';Mshifted(:,1)'],[M(:,2)';Mshifted(:,2)'],'Color','k');
%     title('Antipodal pairs');
%     xlabel('East (x)'); ylabel('North (y)');
%     sz = 25; c = linspace(1,10,m);

    optimal_path = zeros(2*floor(L/1.41/dx)+3,2);
    for i=2 :(2*floor(L/1.41/dx)+2)
        if rem(i,4) == 2
            j = L/1.41;
            k = optimal_path(i-1,1);
        elseif rem(i,4) == 3
            j = L/1.41;
            k = optimal_path(i-1,1)+dx;
        elseif rem(i,4) == 0
            j = 0;
            k = optimal_path(i-1,1);
        else
            j = 0;
            k = optimal_path(i-1,1)+dx;
        end
        optimal_path(i,:) = [k j];

    end

    angle = zeros(size(optimal_path));
    angle(1,3)=abs(atan(optimal_path(2,2)/optimal_path(2,1))*180/pi);

    for i=2:(size(optimal_path)-1)
        if(dot(cross([optimal_path(i,1)-optimal_path(i-1,1) optimal_path(i,2)-optimal_path(i-1,2) 0],[optimal_path(i+1,1)-optimal_path(i,1) optimal_path(i+1,2)-optimal_path(i,2) 0]),[0 0 1])>0)
            j=1;
        else
            j=-1;
        end
        angle(i,3)=j*acos(dot([optimal_path(i,1)-optimal_path(i-1,1) optimal_path(i,2)-optimal_path(i-1,2)],[optimal_path(i+1,1)-optimal_path(i,1) optimal_path(i+1,2)-optimal_path(i,2)])/(norm([optimal_path(i,1)-optimal_path(i-1,1) optimal_path(i,2)-optimal_path(i-1,2)])*norm([optimal_path(i+1,1)-optimal_path(i,1) optimal_path(i+1,2)-optimal_path(i,2)])))*180/pi;

    end

    optimal_path2 = [optimal_path zeros(2*floor(L/1.41/dx)+3,1)+z_cruising];

    tiempo_vasq = toc;

    figure('Position',[10+500 100 500 500]);
    axis equal;
    M = [M zeros(4,1)+z_cruising];
    Mshifted = [Mshifted zeros(4,1)+z_cruising];
    line([M(:,1)';Mshifted(:,1)'],[M(:,2)';Mshifted(:,2)'], [M(:,3)';Mshifted(:,3)'], 'Color','k');
    view(3);
    title('CPP');
    xlabel('East (x)');
    ylabel('North (y)');
    zlabel('depth (z)');
    hold on;
    %i = best_antipodal_pair;

    % Randomly generate points of interest
%     B = rand(C,2)*(L/1.41);
%     B(:,end+1)=z_submarine;
%     X = B(:,1);
%     Y = B(:,2);
%     Z = B(:,3);
%     plot3(X,Y,Z,'r.');
%     objects = B
% Randomly generate points of interest
M = [0 0;L/1.41 0;L/1.41 L/1.41;0 L/1.41];
Mshifted = [L/1.41 0;L/1.41 L/1.41;0 L/1.41;0 0];
M = [M zeros(4,1)+z_submarine];
Mshifted = [Mshifted zeros(4,1)+z_submarine];
line([M(:,1)';Mshifted(:,1)'],[M(:,2)';Mshifted(:,2)'], [M(:,3)';Mshifted(:,3)'], 'Color','b');
    B = rand(C,2)*(L/1.41);
    %B = [21.2070 14.4845; 40.8402   24.9050];
    B(:,end+1)=z_submarine;
    X = B(:,1);
    Y = B(:,2);
    Z = B(:,3);
    plot3(X,Y,Z,'r.');
    objects = B
%     



    optimal_path = [optimal_path zeros(2*floor(L/1.41/dx)+3,1)+z_cruising];
    an = animatedline('Color',[1 .7 .7],'Marker','.');
    orientation = 0;%初始姿态
    ites = size(optimal_path,1)-1;
    i = 1;
    while i <= ites
        %compute orientation and position
        %fprintf('\n i=%d \n', i);
        %orientation = calc_orientation(optimal_path(i, 1:2),optimal_path(i+1, 1:2));
        orientation = rotate(orientation, calc_orientation(optimal_path(i, 1:2),optimal_path(i+1, 1:2)), rot_spd);
        position = optimal_path(i, :);
        
        %[traj, vels, accels] = mtraj(@lspb, optimal_path(i,:),optimal_path(i+1,:), round(norm(optimal_path(i,:) - optimal_path(i+1,:), 2)/transl_spd));
        [optimal_path_new, vels] = traj_new(optimal_path(i:i+1,:), transl_spd, 100, 100, 100, 3, 2, 2, 1.5, 1, 1);
        x = optimal_path_new(:, 1);
        y = optimal_path_new(:, 2);
        z = optimal_path_new(:, 3);
        cur_position = optimal_path_new;
%         x1 = x;
%         y1 = y;
%         z1 = z;
        %x = traj(:, 1);
        %y = traj(:, 2);
        %z = zeros(size(x)) + z_cruising;
        a = tic;
        j=1;
        while j <= size(x, 1)
            b = toc(a);
            if b > 1/fps                  % objects 就是目标点
                [has_object, position_obj] = search_object(objects, [position orientation], detect_radius, work_radius);    %寻找下层目标点search_object： search objects and return only valid objects
                if has_object    %find
                    stop_position = brake([position orientation], vels(j, :), max_deceleration, an,fps);%brake减速制动，返回stop时的position
                    orientation = rotate(orientation, calc_orientation(stop_position(1:2), position_obj(1:2)), rot_spd);
                    position1 = dive(stop_position,position_obj,down_transl_spd,an,fps);
                    position2 = approach(position1 ,position_obj,an,down_transl_spd,fps,Delta_y,Delta_z,down_transl)
                    position = position2;
                    [position, orientation, objects] = greedy_grab([position orientation], objects, work_radius, search_radius, transl_spd, rot_spd, an, fps);
                    orientation = rotate(orientation, calc_orientation(position(1:2), stop_position(1:2)), rot_spd);
                    position = float(position, stop_position, transl_spd, an, fps,down_transl_spd,z_cruising);
                    orientation = rotate(orientation, calc_orientation(stop_position(1:2),optimal_path(i+1,1:2)), rot_spd);
                    %replan trajectory
                    optimal_path(i, :) = stop_position;
                    break 
                else
       
                    
                current = noise();
                cur_position(j,1) = x(j)+current(1);
                cur_position(j,2) = y(j)+current(2);
                cur_position(j,3) = z(j)+current(3);
                if corrent(cur_position(j,:), [x(j) y(j) z(j)], max_distance)
                    addpoints(an, cur_position(j,1), cur_position(j,2), cur_position(j,3));
                    drawnow
                    cur_position(j,:) = [x(j) y(j) z(j)];
                    addpoints(an, cur_position(j,1), cur_position(j,2), cur_position(j,3));
                    drawnow
%                     j = j+1;
%                     a = tic;
                else
                    addpoints(an, cur_position(j,1), cur_position(j,2), cur_position(j,3));
                    drawnow
%                     j = j+1;
%                     a = tic;
                end
                    
                    position = [x(j) y(j) z(j)];
%                     addpoints(an, x(j), y(j), z(j));
%                     drawnow
                    j = j+1;
                    if j == size(x,1)+1
                        i = i+1;
                    end
                    a = tic;
                end
            end
        end
    end

    hold off;