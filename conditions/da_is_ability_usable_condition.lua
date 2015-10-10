
require("libraries/da/da_class_utils")
require("libraries/da/conditions/da_condition")

if DAIsAbilityUsableCondition == nil then
  DAIsAbilityUsableCondition = daDeclareClass(DACondition, function(self, abilityName)
    DACondition.init(self)
    self._abilityName = abilityName
    self._ability = nil
  end)
end

function DAIsAbilityUsableCondition:PrepareToExecute()
  self._ability = self:_GetAbility()
end

function DAIsAbilityUsableCondition:Execute()
  if self._ability and self._ability:IsFullyCastable() then
    self:Success()
  else
    self:Fail()
  end
end

function DAIsAbilityUsableCondition:FinishedExecuting()
  self._ability = nil
end

function DAIsAbilityUsableCondition:_GetAbility()
  local ability = nil
  local entity = self:GetTree():GetEntity()

  if entity then
    ability = entity:FindAbilityByName(self._abilityName)
  end

  return ability
end
