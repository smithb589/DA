
--[[
Conditions are used to communicate status information back to the behavior tree.
For example, a condition can be used in a sequence to prevent subsequent tasks
from being run if the condition fails.
]]

require("libraries/da/da_class_utils")
require("libraries/da/da_task")

if DACondition == nil then
  DACondition = daDeclareClass(DATask, function(self)
    DATask.init(self)
  end)
end


