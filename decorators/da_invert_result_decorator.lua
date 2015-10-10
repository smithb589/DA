
require("libraries/da/da_class_utils")
require("libraries/da/decorators/da_decorator")

if DAInvertResultDecorator == nil then
  DAInvertResultDecorator = daDeclareClass(DADecorator, function(self, decoratedTask)
    DADecorator.init(self, decoratedTask)
  end)
end

function DAInvertResultDecorator:HandleChildFailure()
  if self._parentTask then
    self._parentTask:HandleChildSuccess(self._decoratedTask)
  end
end

function DAInvertResultDecorator:HandleChildSuccess()
  if self._parentTask then
    self._parentTask:HandleChildFailure(self._decoratedTask)
  end
end
