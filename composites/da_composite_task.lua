
--[[
Composites are tasks that don't really do anything themselves. However,
they contain one or more tasks to be executed.
]]

require("libraries/da/da_class_utils")
require("libraries/da/da_task")

if DACompositeTask == nil then
  DACompositeTask = daDeclareClass(DATask, function(self, nodeTable)
    DATask.init(self)
    self._nodeTable = nodeTable

    for _, node in ipairs(self._nodeTable) do
      node:SetParent(self)
    end

    self._lastSubtaskStatus = nil
    self._runningNodeIndex = nil
  end)
end

function DACompositeTask:SetTree(tree)
  DATask.SetTree(self, tree)
  for _, node in ipairs(self._nodeTable) do
    node:SetTree(tree)
  end
end

function DACompositeTask:GetNodeTable()
  return self._nodeTable
end

function DACompositeTask:PrepareToExecute()
  self._lastSubtaskStatus = TASK_FAILED
  self._runningNodeIndex = 1
end

function DACompositeTask:Execute()
  local taskToRun = self:GetNodeTable()[self._runningNodeIndex]
  if taskToRun ~= nil then
    if self._lastSubtaskStatus ~= TASK_RUNNING then
      taskToRun:PrepareToExecute()
    end
    self._lastSubtaskStatus = TASK_RUNNING
    taskToRun:Execute()
  else
    print(string.format("Composite task didn't have a subtask to run at index %d.", self._runningNodeIndex))
    self:Fail()
    --DeepPrintTable(self)
  end
end

function DACompositeTask:FinishedExecuting()
  self._runningNodeIndex = nil
end

function DACompositeTask:HandleChildFailure(childTask)
  DADebugPrint("Default composite task HandleChildFailure called. Did you forget to override it?")
  self:Fail()
end

function DACompositeTask:HandleChildSuccess(childTask)
  DADebugPrint("Default composite task HandleChildSuccess called. Did you forget to override it?")
  self:Fail()
end

function DACompositeTask:AdvanceRunningNodeIndex()
  self._runningNodeIndex = self._runningNodeIndex + 1
end

function DACompositeTask:HasRemainingTasks()
  return self._runningNodeIndex >= 1 and self._runningNodeIndex <= #self:GetNodeTable()
end

function DACompositeTask:SetLastSubtaskStatus(taskStatus)
  self._lastSubtaskStatus = taskStatus
end
