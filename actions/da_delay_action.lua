
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

if DADelayAction == nil then
  DADelayAction = daDeclareClass(DAAction, function(self, duration)
    DAAction.init(self)
    self._delayDuration = duration
  end)
end

function DADelayAction:PrepareToExecute()
  self._delayEndTime = GameRules:GetGameTime() + self._delayDuration
end

function DADelayAction:Execute()
  if self._delayEndTime then
    if self:_IsDelayFinished() then
      self:Success()
    end
  else
    print("Attempted a delay action with no end time.")
    self:Fail()
  end
end

function DADelayAction:FinishedExecuting()
  self._delayEndTime = nil
end

function DADelayAction:_IsDelayFinished()
  return GameRules:GetGameTime() >= self._delayEndTime
end
