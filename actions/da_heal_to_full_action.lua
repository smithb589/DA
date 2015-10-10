
require("libraries/da/da_class_utils")

require("libraries/da/actions/da_action")

if DAHealToFullAction == nil then
  DAHealToFullAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DAHealToFullAction:Execute()
  local entity = self:GetEntity()
  if entity then
    entity:SetHealth(entity:GetMaxHealth())
    self:Success()
  else
    print("No entity to heal.")
    self:Fail()
  end
end
