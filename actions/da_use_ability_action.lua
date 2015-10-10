
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

if DAUseAbilityAction == nil then
  DAUseAbilityAction = daDeclareClass(DAAction, function(self, abilityName)
    DAAction.init(self)

    self._abilityName = abilityName
    self._castEndTime = nil
  end)
end

function DAUseAbilityAction:PrepareToExecute()
  local entity = self:GetEntity()
  local ability = entity:FindAbilityByName(self._abilityName)
  local animationDuration = ability:GetCastPoint() + ability:GetBackswingTime()

  ability:CastAbility()
  self._castEndTime = GameRules:GetGameTime() + animationDuration
end

function DAUseAbilityAction:Execute()
  if self._castEndTime then
    if GameRules:GetGameTime() >= self._castEndTime then
      self:Success()
    end
  else
    print(string.format("No cast end time for ability %s.", self._abilityName))
  end
end

function DAUseAbilityAction:FinishedExecuting()
  self._castEndTime = nil
end
