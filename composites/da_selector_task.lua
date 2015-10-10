
--[[
A selector task executes each subtask in the order provided
until one succeeds. It only reports a failure if all subtasks fail.
Note that a maximum of one successful subtask will be executed.
]]

require("libraries/da/da_class_utils")
require("libraries/da/composites/da_composite_task")

if DASelectorTask == nil then
  DASelectorTask = daDeclareClass(DACompositeTask, function(self, nodeTable)
    DACompositeTask.init(self, nodeTable)
  end)
end

-- Override from composite task
function DASelectorTask:HandleChildFailure(childTask)
  self:SetLastSubtaskStatus(TASK_FAILED)
  self:AdvanceRunningNodeIndex()
  if self:HasRemainingTasks() then
    self:Execute()
  else
    self:Fail()
  end
end

-- Override from composite task
function DASelectorTask:HandleChildSuccess(childTask)
  self:SetLastSubtaskStatus(TASK_SUCCESS)
  self:AdvanceRunningNodeIndex()
  self:Success()
end
