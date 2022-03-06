classdef spacetime_event
    %SPACETIME_EVENT this is a spacetime event
    
    properties
        name = ""
        x = [0; 0; 0; 0]
        color = ""
    end
    
    methods
        
        function obj = spacetime_event(name, x, color)
            %Construct an instance of this class
            obj.name = name;
            obj.x = x;
            obj.color = color;
        end
        
        function obj = boost_x1(obj, v, name_mod)
            %Return a new spacetime_event after a boost in the x_1
            %direction, this should be in a new reference frame
            obj.name = [obj.name + name_mod];
            Lambda_x1 = [
                [gam(v),        -gam(v) * v,	0,  0];
                [-gam(v) * v,   gam(v),         0,  0];
                [0,             0,              1,  0];
                [0,             0,              0,  1]
                ];
            obj.x = Lambda_x1 * obj.x;
        end
        
        function obj = rotate_xy(obj, theta, name_mod)
            %Return a new spacetime_event after a boost in the x_1
            %direction, this should be in a new reference frame
            obj.name = [obj.name + name_mod];
            Lambda_x1 = [
                [1, 0,              0,          0];
                [0, cos(theta),     sin(theta), 0];
                [0, -sin(theta),    cos(theta), 0];
                [0, 0,              0,          1]
                ];
            obj.x = Lambda_x1 * obj.x;
        end  
        
        function obj = transpose(obj, delta, name_mod)
            obj.name = [obj.name + name_mod];
            obj.x = obj.x + delta;
        end
        
            
            
    end
end

