
require("libraries/da/da_class_utils")

require("libraries/da/actions/da_action")

if DADespawnAction == nil then
  DADespawnAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DADespawnAction:Execute()
  local entity = self:GetEntity()
  if entity then
    UTIL_Remove(entity)
    self:Success()
  else
    print("Unable to despawn nil entity.")
    self:Fail()
  end
end
