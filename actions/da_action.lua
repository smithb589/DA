
--[[
Actions are the leaf nodes of a behavior tree. These are responsible for
causing an entity to do something.
]]

require("libraries/da/da_class_utils")
require("libraries/da/da_task")

if DAAction == nil then
  DAAction = daDeclareClass(DATask, function(self)
    DATask.init(self)
  end)
end


