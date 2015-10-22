
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

-- Sets the blackboard position from an offset of the current position
if DASetCurrentPositionAction == nil then
  DASetCurrentPositionAction = daDeclareClass(DAAction, function(self, blackboardValueName)
    DAAction.init(self)

    self._blackboardValueName = blackboardValueName
  end)
end

function DASetCurrentPositionAction:Execute()
  local position = self:_DeterminePosition()
  if position then
    self:GetBlackboard():Put(self._blackboardValueName, position)
    self:Success()
  else
    print(string.format("No position to set for %s", self:GetEntity():GetUnitName()))
    self:Fail()
  end
end

function DASetCurrentPositionAction:_DeterminePosition()
  local position = nil
  local entity = self:GetEntity()
  if entity then
    position = entity:GetAbsOrigin()
  end

  return position
end