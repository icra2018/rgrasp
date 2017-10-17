classdef APC_Scenario < robotics.ros.Message
    %APC_Scenario MATLAB implementation of apc_planning/APC_Scenario
    %   This class was automatically generated by
    %   robotics.ros.msg.internal.gen.MessageClassGenerator.
    
    %   Copyright 2014-2017 The MathWorks, Inc.
    
    %#ok<*INUSD>
    
    properties (Constant)
        MessageType = 'apc_planning/APC_Scenario' % The ROS message type
    end
    
    properties (Constant, Hidden)
        MD5Checksum = 'd2c36cfde883026d60d22ad500826e51' % The MD5 Checksum of the message definition
    end
    
    properties (Access = protected)
        JavaMessage % The Java message object
    end
    
    properties (Constant, Access = protected)
        ApcPlanningAPCObjectClass = robotics.ros.msg.internal.MessageFactory.getClassForType('apc_planning/APC_Object') % Dispatch to MATLAB class for message type apc_planning/APC_Object
        StdMsgsHeaderClass = robotics.ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
    end
    
    properties (Dependent)
        Header
        NumObjects
        GoalObject
        Primitive
        Result
        Objects
    end
    
    properties (Access = protected)
        Cache = struct('Header', [], 'Objects', []) % The cache for fast data access
    end
    
    properties (Constant, Hidden)
        PropertyList = {'GoalObject', 'Header', 'NumObjects', 'Objects', 'Primitive', 'Result'} % List of non-constant message properties
        ROSPropertyList = {'goal_object', 'header', 'num_objects', 'objects', 'primitive', 'result'} % List of non-constant ROS message properties
    end
    
    methods
        function obj = APC_Scenario(msg)
            %APC_Scenario Construct the message object APC_Scenario
            import com.mathworks.toolbox.robotics.ros.message.MessageInfo;
            
            % Support default constructor
            if nargin == 0
                obj.JavaMessage = obj.createNewJavaMessage;
                return;
            end
            
            % Construct appropriate empty array
            if isempty(msg)
                obj = obj.empty(0,1);
                return;
            end
            
            % Make scalar construction fast
            if isscalar(msg)
                % Check for correct input class
                if ~MessageInfo.compareTypes(msg(1), obj.MessageType)
                    error(message('robotics:ros:message:NoTypeMatch', obj.MessageType, ...
                        char(MessageInfo.getType(msg(1))) ));
                end
                obj.JavaMessage = msg(1);
                return;
            end
            
            % Check that this is a vector of scalar messages. Since this
            % is an object array, use arrayfun to verify.
            if ~all(arrayfun(@isscalar, msg))
                error(message('robotics:ros:message:MessageArraySizeError'));
            end
            
            % Check that all messages in the array have the correct type
            if ~all(arrayfun(@(x) MessageInfo.compareTypes(x, obj.MessageType), msg))
                error(message('robotics:ros:message:NoTypeMatchArray', obj.MessageType));
            end
            
            % Construct array of objects if necessary
            objType = class(obj);
            for i = 1:length(msg)
                obj(i,1) = feval(objType, msg(i)); %#ok<AGROW>
            end
        end
        
        function header = get.Header(obj)
            %get.Header Get the value for property Header
            if isempty(obj.Cache.Header)
                obj.Cache.Header = feval(obj.StdMsgsHeaderClass, obj.JavaMessage.getHeader);
            end
            header = obj.Cache.Header;
        end
        
        function set.Header(obj, header)
            %set.Header Set the value for property Header
            validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'APC_Scenario', 'Header');
            
            obj.JavaMessage.setHeader(header.getJavaObject);
            
            % Update cache if necessary
            if ~isempty(obj.Cache.Header)
                obj.Cache.Header.setJavaObject(header.getJavaObject);
            end
        end
        
        function numobjects = get.NumObjects(obj)
            %get.NumObjects Get the value for property NumObjects
            numobjects = int32(obj.JavaMessage.getNumObjects);
        end
        
        function set.NumObjects(obj, numobjects)
            %set.NumObjects Set the value for property NumObjects
            validateattributes(numobjects, {'numeric'}, {'nonempty', 'scalar'}, 'APC_Scenario', 'NumObjects');
            
            obj.JavaMessage.setNumObjects(numobjects);
        end
        
        function goalobject = get.GoalObject(obj)
            %get.GoalObject Get the value for property GoalObject
            goalobject = int32(obj.JavaMessage.getGoalObject);
        end
        
        function set.GoalObject(obj, goalobject)
            %set.GoalObject Set the value for property GoalObject
            validateattributes(goalobject, {'numeric'}, {'nonempty', 'scalar'}, 'APC_Scenario', 'GoalObject');
            
            obj.JavaMessage.setGoalObject(goalobject);
        end
        
        function primitive = get.Primitive(obj)
            %get.Primitive Get the value for property Primitive
            primitive = char(obj.JavaMessage.getPrimitive);
        end
        
        function set.Primitive(obj, primitive)
            %set.Primitive Set the value for property Primitive
            validateattributes(primitive, {'char'}, {}, 'APC_Scenario', 'Primitive');
            
            obj.JavaMessage.setPrimitive(primitive);
        end
        
        function result = get.Result(obj)
            %get.Result Get the value for property Result
            result = int32(obj.JavaMessage.getResult);
        end
        
        function set.Result(obj, result)
            %set.Result Set the value for property Result
            validateattributes(result, {'numeric'}, {'nonempty', 'scalar'}, 'APC_Scenario', 'Result');
            
            obj.JavaMessage.setResult(result);
        end
        
        function objects = get.Objects(obj)
            %get.Objects Get the value for property Objects
            if isempty(obj.Cache.Objects)
                javaArray = obj.JavaMessage.getObjects;
                array = obj.readJavaArray(javaArray, obj.ApcPlanningAPCObjectClass);
                obj.Cache.Objects = feval(obj.ApcPlanningAPCObjectClass, array);
            end
            objects = obj.Cache.Objects;
        end
        
        function set.Objects(obj, objects)
            %set.Objects Set the value for property Objects
            if ~isvector(objects) && isempty(objects)
                % Allow empty [] input
                objects = feval([obj.ApcPlanningAPCObjectClass '.empty'], 0, 1);
            end
            
            validateattributes(objects, {obj.ApcPlanningAPCObjectClass}, {'vector'}, 'APC_Scenario', 'Objects');
            
            javaArray = obj.JavaMessage.getObjects;
            array = obj.writeJavaArray(objects, javaArray, obj.ApcPlanningAPCObjectClass);
            obj.JavaMessage.setObjects(array);
            
            % Update cache if necessary
            if ~isempty(obj.Cache.Objects)
                obj.Cache.Objects = [];
                obj.Cache.Objects = obj.Objects;
            end
        end
    end
    
    methods (Access = protected)
        function resetCache(obj)
            %resetCache Resets any cached properties
            obj.Cache.Header = [];
            obj.Cache.Objects = [];
        end
        
        function cpObj = copyElement(obj)
            %copyElement Implements deep copy behavior for message
            
            % Call default copy method for shallow copy
            cpObj = copyElement@robotics.ros.Message(obj);
            
            % Clear any existing cached properties
            cpObj.resetCache;
            
            % Create a new Java message object
            cpObj.JavaMessage = obj.createNewJavaMessage;
            
            % Iterate over all primitive properties
            cpObj.NumObjects = obj.NumObjects;
            cpObj.GoalObject = obj.GoalObject;
            cpObj.Primitive = obj.Primitive;
            cpObj.Result = obj.Result;
            
            % Recursively copy compound properties
            cpObj.Header = copy(obj.Header);
            cpObj.Objects = copy(obj.Objects);
        end
        
        function reload(obj, strObj)
            %reload Called by loadobj to assign properties
            obj.NumObjects = strObj.NumObjects;
            obj.GoalObject = strObj.GoalObject;
            obj.Primitive = strObj.Primitive;
            obj.Result = strObj.Result;
            obj.Header = feval([obj.StdMsgsHeaderClass '.loadobj'], strObj.Header);
            ObjectsCell = arrayfun(@(x) feval([obj.ApcPlanningAPCObjectClass '.loadobj'], x), strObj.Objects, 'UniformOutput', false);
            obj.Objects = vertcat(ObjectsCell{:});
        end
    end
    
    methods (Access = ?robotics.ros.Message)
        function strObj = saveobj(obj)
            %saveobj Implements saving of message to MAT file
            
            % Return an empty element if object array is empty
            if isempty(obj)
                strObj = struct.empty;
                return
            end
            
            strObj.NumObjects = obj.NumObjects;
            strObj.GoalObject = obj.GoalObject;
            strObj.Primitive = obj.Primitive;
            strObj.Result = obj.Result;
            strObj.Header = saveobj(obj.Header);
            strObj.Objects = arrayfun(@(x) saveobj(x), obj.Objects);
        end
    end
    
    methods (Static, Access = {?matlab.unittest.TestCase, ?robotics.ros.Message})
        function obj = loadobj(strObj)
            %loadobj Implements loading of message from MAT file
            
            % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = robotics.ros.custom.msggen.apc_planning.APC_Scenario.empty(0,1);
                return
            end
            
            % Create an empty message object
            obj = robotics.ros.custom.msggen.apc_planning.APC_Scenario;
            obj.reload(strObj);
        end
    end
end