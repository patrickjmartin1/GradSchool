classdef spacetime_event
    %SPACETIME_EVENT this is a spacetime event
    
    properties
        name = ""
        t = 0
        x = 0
        y = 0
        z = 0
        color = ""
    end
    
    methods
        
        function obj = spacetime_event(name, t, x, color)
            %Construct an instance of this class
            obj.name = name;
            obj.t = t;
            obj.x = x;
            obj.color = color;
        end
        
        function obj = boost(obj, v, name_mod)
            obj.name = [obj.name + name_mod];
            t_prime = gam(v) * (obj.t - v*obj.x);
            x_prime = gam(v) * (obj.x - v*obj.t);
            obj.t = t_prime;
            obj.x = x_prime;
        end    
        
        function obj = transpose(obj, delta_x, delta_y, delta_z, name_mod)
            obj.name = [obj.name + name_mod];
            obj.x = obj.x + delta_x;
            obj.y = obj.y + delta_y;
            obj.z = obj.z + delta_z;
        end
            
            
    end
end

