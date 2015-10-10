
if DAUnitSpawnUtils == nil then
  DAUnitSpawnUtils = {}
end

function DAUnitSpawnUtils:AttachSpawnPositionToEntity(unit, position)
  unit.spawnPosition = position
end

function DAUnitSpawnUtils:GetSpawnPositionFromEntity(unit)
  return unit.spawnPosition
end

