
require("libraries/da/da_class_utils")
require("libraries/da/conditions/da_condition")

if DAIsBlackboardValueTrueCondition == nil then
  DAIsBlackboardValueTrueCondition = daDeclareClass(DACondition, function(self, blackboardValueName)
    DACondition.init(self)

    self._blackboardValueName = blackboardValueName
  end)
end

function DAIsBlackboardValueTrueCondition:Execute()
  if self._blackboardValueName then
    local value = self:GetBlackboard():Get(self._blackboardValueName)
    if value == true then
      self:Success()
    else
      self:Fail()
    end
  else
    if self:IsDebugOutputEnabled() then
      print(string.format("No blackboard value name to check value for for %s.", self:GetEntity():GetUnitName()))
    end
    self:Fail()
  end
end

function DAIsBlackboardValueTrueCondition:OutputSuccessMessage()
  print(string.format("Value %s was true.", self._blackboardValueName))
end

function DAIsBlackboardValueTrueCondition:OutputFailMessage()
  print(string.format("Value %s was false.", self._blackboardValueName))
end
