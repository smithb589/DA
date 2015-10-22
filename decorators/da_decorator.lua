
--[[
Decorators wrap a task to modify something about it. For example, a decorator
may cause a task to always return failure or success regardless of what actually
happened.
]]

require("libraries/da/da_class_utils")
require("libraries/da/da_task")

if DADecorator == nil then
  DADecorator = daDeclareClass(DATask, function(self, decoratedTask)
    DATask.init(self)
    self._decoratedTask = decoratedTask
    self._decoratedTask:SetParent(self)
  end)
end

function DADecorator:GetDecoratedTask()
  return self._decoratedTask
end

function DADecorator:SetTree(tree)
  DATask.SetTree(self, tree)
  self._decoratedTask:SetTree(tree)
end

function DADecorator:PrepareToExecute()
  self._decoratedTask:PrepareToExecute()
end

function DADecorator:Execute()
  self._decoratedTask:Execute()
end

function DADecorator:FinishedExecuting()
  self._decoratedTask:FinishedExecuting()
  DATask.FinishedExecuting(self)
end

function DADecorator:HandleChildFailure(childTask)
  if self._parentTask then
    self._parentTask:HandleChildFailure(self._decoratedTask)
  end
end

function DADecorator:HandleChildSuccess(childTask)
  if self._parentTask then
    self._parentTask:HandleChildSuccess(self._decoratedTask)
  end
end
