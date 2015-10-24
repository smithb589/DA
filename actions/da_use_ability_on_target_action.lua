
require("libraries/da/da_class_utils")

require("libraries/da/actions/da_action")

require("libraries/da/orders/da_cast_target_order")

if DAUseAbilityOnTargetAction == nil then
  DAUseAbilityOnTargetAction = daDeclareClass(DAAction, function(self, abilityName, blackboardTargetValueName)
    DAAction.init(self)
    self._abilityName = abilityName
    self._targetValueName = blackboardTargetValueName

    self._castEndTime = nil
  end)
end

function DAUseAbilityOnTargetAction:PrepareToExecute()
  local target = self:_DetermineTarget()
  local ability = self:_GetAbility()
  local orderedUnit = self:GetEntity()

  if target and ability and orderedUnit then
    orderedUnit:CastAbilityOnTarget(target, ability, target:GetPlayerOwner():entindex())
    local animationDuration = ability:GetCastPoint() + ability:GetBackswingTime()
    self._castEndTime = GameRules:GetGameTime() + animationDuration
  end
end

function DAUseAbilityOnTargetAction:Execute()
  if self._castEndTime then
    if GameRules:GetGameTime() >= self._castEndTime then
      self:Success()
    end
    -- local abilityOrder = DACastTargetOrder(self._orderedUnit, self._ability:entindex(), self._target)
    -- abilityOrder:IssueOrder()
  else
    self:Fail()
  end
end

function DAUseAbilityOnTargetAction:FinishedExecuting()
  self._castEndTime = nil
end

function DAUseAbilityOnTargetAction:_DetermineTarget()
  local target = self:GetBlackboard():Get(self._targetValueName)
  return target
end

function DAUseAbilityOnTargetAction:_GetAbility()
  local ability = nil
  local entity = self:GetEntity()

  if entity then
    ability = entity:FindAbilityByName(self._abilityName)
  end

  return ability
end

function DAUseAbilityOnTargetAction:OutputSuccessMessage()
  local format = "%s cast ability %s."
  print(string.format(format, self:GetEntity():GetUnitName(), self._abilityName))
end

function DAUseAbilityOnTargetAction:OutputFailMessage()
  local format = "Failed to cast ability %s."
  print(string.format(format, self._abilityName))
end

