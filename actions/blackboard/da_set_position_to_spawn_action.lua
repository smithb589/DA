
require("libraries/da/da_class_utils")
require("libraries/da/da_unit_spawn_utils")
require("libraries/da/actions/blackboard/da_set_position_action")

if DASetPositionToSpawnAction == nil then
  DASetPositionToSpawnAction = daDeclareClass(DASetPositionAction, function(self)
    DASetPositionAction.init(self)
  end)
end

function DASetPositionToSpawnAction:_DeterminePosition()
  local entity = self:GetEntity()
  local spawnPosition = DAUnitSpawnUtils:GetSpawnPositionFromEntity(entity)
  return spawnPosition
end