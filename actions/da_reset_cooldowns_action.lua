
require("libraries/da/da_class_utils")

require("libraries/da/actions/da_action")

if DAResetCooldownsAction == nil then
  DAResetCooldownsAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DAResetCooldownsAction:Execute()
  local entity = self:GetEntity()
  if entity then
    self:EndCooldowns(entity)      
    self:Success()
  else
    print("No entity to reset cooldowns for.")
    self:Fail()
  end
end

function DAResetCooldownsAction:EndCooldowns(entity)
  local numberOfAbilities = entity:GetAbilityCount()

  for abilityIndex = 0, (numberOfAbilities - 1) do
    local ability = entity:GetAbilityByIndex(abilityIndex)
    if ability then
      ability:EndCooldown()
    end
  end
end