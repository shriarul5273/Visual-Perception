function world_coordinates = make_3Dworld(xlim,ylim,zlim)
%% make_3Dworld to create a 3D work from xlim,ylim,zlim
%   Input
%       xlim - The end of the x coordinate
%       ylim - The end of the y coordinate
%       zlim - The end of the z coordinate
%
%   Output
%         world_coordinates - created world with the limits
%% Function starts here
    world = [];
    %looping over to create the XY plane
    for x=10:20:xlim
        for y = 10:20:ylim
            b = [x,y,10];
         world = vertcat(world,b);
        end
    end
    
    %looping over to create the YZ plane
    for y=10:20:ylim
        for z = 10:20:zlim
            b = [10,y,z];
         world = vertcat(world,b);
        end
    end
    
    %looping over to create the XZ plane
    for x=10:20:xlim
        for z = 10:20:zlim
            b = [x,10,z];
         world = vertcat(world,b);
        end
    end

    %randomize the worldpoints 
    rows = randperm(size(world, 1));

    world_coordinates = world(rows,:);
    world_coordinates(:,4) = 1 ;
end