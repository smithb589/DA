
require("libraries/da/da_class_utils")
require("libraries/da/decorators/da_decorator")

if DAAlwaysFailDecorator == nil then
  DAAlwaysFailDecorator = daDeclareClass(DADecorator, function(self, decoratedTask)
    DADecorator.init(self, decoratedTask)
  end)
end

function DAAlwaysFailDecorator:HandleChildFailure()
  if self._parentTask then
    self._parentTask:HandleChildFailure(self._decoratedTask)
  end
end

function DAAlwaysFailDecorator:HandleChildSuccess()
  if self._parentTask then
    self._parentTask:HandleChildFailure(self._decoratedTask)
  end
end

