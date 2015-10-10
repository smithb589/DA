
--[[
A sequence task executes each of its subtasks in the order provided
as long as each one is successful. If one subtask fails, no subsequent
subtasks are executed.
]]

require("libraries/da/da_class_utils")
require("libraries/da/composites/da_composite_task")

if DASequenceTask == nil then
  DASequenceTask = daDeclareClass(DACompositeTask, function(self, nodeTable)
    DACompositeTask.init(self, nodeTable)
  end)
end

-- Override from composite task
function DASequenceTask:HandleChildFailure(childTask)
  self:SetLastSubtaskStatus(TASK_FAILED)
  self:AdvanceRunningNodeIndex()
  self:Fail()
end

-- Override from composite task
function DASequenceTask:HandleChildSuccess(childTask)
  self:SetLastSubtaskStatus(TASK_SUCCESSFUL)
  self:AdvanceRunningNodeIndex()
  if self:HasRemainingTasks() then
    self:Execute()
  else
    self:Success()
  end
end