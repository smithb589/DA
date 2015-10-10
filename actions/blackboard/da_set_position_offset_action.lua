
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

-- Sets the blackboard position from an offset of the current position
if DASetPositionOffsetAction == nil then
  DASetPositionOffsetAction = daDeclareClass(DAAction, function(self, offsetVector)
    DAAction.init(self)

    self._offset = offsetVector
  end)
end

function DASetPositionOffsetAction:Execute()
  local position = self:GetEntity():GetAbsOrigin() + self._offset
  self:GetBlackboard():Put("position", position)
  self:Success()
end
