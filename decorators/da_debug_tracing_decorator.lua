
require("libraries/da/da_class_utils")

require("libraries/da/decorators/da_decorator")

if DADebugTracingDecorator == nil then
  DADebugTracingDecorator = daDeclareClass(DADecorator, function(self, decoratedTask, taskName)
    DADecorator.init(self, decoratedTask)

    self._taskName = taskName  
  end)
end

function DADebugTracingDecorator:SetTree(tree)
  DADecorator.SetTree(self, tree)
  self._unitName = self:GetEntity():GetUnitName()
end

function DADebugTracingDecorator:PrepareToExecute()
  --print(string.format("Preparing to execute task %s.", self._taskName))
  DADecorator.PrepareToExecute(self)
end

function DADebugTracingDecorator:HandleChildFailure(childTask)
  if self:IsDebugOutputEnabled() then
    print(string.format("Task %s failed for %s.", self._taskName, self._unitName))
  end
  if self._parentTask then
    self._parentTask:HandleChildFailure(self._decoratedTask)
  end
end

function DADebugTracingDecorator:HandleChildSuccess(childTask)
  if self:IsDebugOutputEnabled() then
    print(string.format("Task %s was successful for %s.", self._taskName, self._unitName))
  end
  if self._parentTask then
    self._parentTask:HandleChildSuccess(self._decoratedTask)
  end
end