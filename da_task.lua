-- Note that additions to the base task will need overrides
-- to dispatch them to decorated tasks in /ai/decorators/da_decorator

require("libraries/da/da_class_utils")

TASK_SUCCESSFUL = 1
TASK_FAILED = 2
TASK_RUNNING = 3

if DATask == nil then
  DATask = daDeclareClass({}, function(self)
    self._parentTask = nil
    self._tree = nil
  end)
end

function DATask:SetParent(parentTask)
  self._parentTask = parentTask
end

function DATask:SetTree(tree)
  self._tree = tree
end

function DATask:GetTree()
  return self._tree
end

function DATask:GetEntity()
  return self._tree:GetEntity()
end

function DATask:GetBlackboard()
  return self._tree:GetBlackboard()
end

function DATask:GetName()

end

function DATask:IsDebugOutputEnabled()
  return self._tree:IsDebugOutputEnabled()
end

function DATask:PrintDebugMessage(message)
  if self:IsDebugOutputEnabled() then
    print(message)
  end
end

function DATask:PrintDebugMessageFormat(messageFormat, ...)
  if self:IsDebugOutputEnabled() then
    print(string.format(messageFormat, ...))
  end
end

function DATask:PrepareToExecute()

end

-- Runs the task, must return true on success and false on failure
function DATask:Execute()
  print("Default execution called for a task. Did you forget to override Execute?")
  self:Fail()
end

function DATask:FinishedExecuting()

end

function DATask:OutputSuccessMessage()

end

function DATask:OutputFailMessage()

end

function DATask:Fail()
  if self:IsDebugOutputEnabled() then
    self:OutputFailMessage()
  end

  self:FinishedExecuting()
  if self._parentTask then
    self._parentTask:HandleChildFailure(self)
  end
end

function DATask:Success()
  if self:IsDebugOutputEnabled() then
    self:OutputSuccessMessage()
  end

  self:FinishedExecuting()
  if self._parentTask then
    self._parentTask:HandleChildSuccess(self)
  end
end
