
require("libraries/da/da_class_utils")
require("libraries/da/actions/blackboard/da_set_position_action")

-- Sets the blackboard position from an offset of the current position
if DASetPositionOffsetAction == nil then
  DASetPositionOffsetAction = daDeclareClass(DASetPositionAction, function(self, offsetVector, blackboardValueName)
    DASetPositionAction.init(self, blackboardValueName)

    self._offset = offsetVector
  end)
end

function DASetPositionOffsetAction:_DeterminePosition()
  local position = self:GetEntity():GetAbsOrigin() + self._offset
  return position
end