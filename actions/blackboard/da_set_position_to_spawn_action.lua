
require("libraries/da/da_class_utils")
require("libraries/da/da_unit_spawn_utils")

if DASetPositionToSpawnAction == nil then
  DASetPositionToSpawnAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DASetPositionToSpawnAction:Execute()
  local blackboard = self:GetBlackboard()
  local entity = self:GetEntity()
  local spawnPosition = DAUnitSpawnUtils:GetSpawnPositionFromEntity(entity)
  blackboard:Put("position", spawnPosition)
  self:Success()
end
