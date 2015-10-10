
require("libraries/da/da_class_utils")

require("libraries/da/actions/da_action")

require("libraries/da/orders/da_cast_target_order")

if DAUseAbilityOnTargetAction == nil then
  DAUseAbilityOnTargetAction = daDeclareClass(DAAction, function(self, abilityName)
    DAAction.init(self)
    self._abilityName = abilityName
    self._target = nil
    self._orderedUnit = nil
    self._abilityIndex = nil
  end)
end

function DAUseAbilityOnTargetAction:PrepareToExecute()
  self._target = self:_DetermineTarget()
  self._abilityIndex = self:_GetAbilityIndex()
  self._orderedUnit = self:GetEntity()
end

function DAUseAbilityOnTargetAction:Execute()
  if self._target and self._orderedUnit and self._abilityIndex then
    local abilityOrder = DACastTargetOrder(self._orderedUnit, self._abilityIndex, self._target)
    abilityOrder:IssueOrder()
    self:Success()
  else
    self:Fail()
  end
end

function DAUseAbilityOnTargetAction:FinishedExecuting()
  self._target = nil
  self._abilityIndex = nil
  self._orderedUnit = nil
end

function DAUseAbilityOnTargetAction:_DetermineTarget()
  print("Base version of _DetermineTarget called. Did you forget to override?")
  return nil
end

function DAUseAbilityOnTargetAction:_GetAbilityIndex()
  local abilityIndex = nil
  local entity = self:GetEntity()

  if entity then
    local ability = entity:FindAbilityByName(self._abilityName)
    abilityIndex = ability:entindex()
  end

  return abilityIndex
end
