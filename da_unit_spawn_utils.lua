
if DDUnitSpawnUtils == nil then
  DDUnitSpawnUtils = {}
end

function DDUnitSpawnUtils:AttachSpawnPositionToEntity(unit, position)
  unit.spawnPosition = position
end

function DDUnitSpawnUtils:GetSpawnPositionFromEntity(unit)
  return unit.spawnPosition
end

