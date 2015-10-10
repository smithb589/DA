
--[[
A parallel task executes all subtasks but only returns success itself if all
subtasks were successful.
]]

require("libraries/da/da_class_utils")
require("libraries/da/composites/da_composite_task")

if DAParallelTask == nil then
  DAParallelTask = daDeclareClass(DACompositeTask, function(self, nodeTable)
    DACompositeTask.init(self, nodeTable)

    self._allSuccessful = true
  end)
end

-- Override from composite task.
function DAParallelTask:PrepareToExecute()
  DACompositeTask.PrepareToExecute(self)
  self._allSuccessful = true
end

-- Override from composite task
function DAParallelTask:HandleChildFailure(childTask)
  self._allSuccessful = false
  self:_HandleNextTask()
end

-- Override from composite task
function DAParallelTask:HandleChildSuccess(childTask)
  self:SetLastSubtaskStatus(TASK_SUCCESSFUL)
  self:_HandleNextTask()
end

function DAParallelTask:_HandleNextTask()
  self:AdvanceRunningNodeIndex()
  if self:HasRemainingTasks() then
    self:Execute()
  elseif self._allSuccessful then
    self:Success()
  else
    self:Fail()
  end
end
