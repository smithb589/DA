
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

if DACalculateBlackboardValueAction == nil then
  DACalculateBlackboardValueAction = daDeclareClass(DAAction, function(self, blackboardValueName)
    DAAction.init(self)
    self._blackboardValueName = blackboardValueName
  end)
end

function DACalculateBlackboardValueAction:PrepareToExecute()
  if self._blackboardValueName then
    self._blackboardValue = self:_CalculateBlackboardValue()
  end
end

function DACalculateBlackboardValueAction:Execute()
  if self._blackboardValue then
    self:GetBlackboard():Put(self._blackboardValueName, self._blackboardValue)
    self:Success()
  else
    if self:IsDebugOutputEnabled() then
      print(string.format("No blackboard value to set for %s.", self._blackboardValueName))
    end
    self:Fail()
  end
end

function DACalculateBlackboardValueAction:FinishedExecuting()
  self._blackboardValue = nil
end

function DACalculateBlackboardValueAction:_CalculateBlackboardValue()
  print("Default DACalculateBlackboardValueAction:_CalculateBlackboardValue called. Did you forget to override it?")
  return nil
end
