
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

-- Sets the blackboard position from an offset of the current position
if DASetPositionAction == nil then
  DASetPositionAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DASetPositionAction:Execute()
  local position = self:_DeterminePosition()
  if position then
    self:GetBlackboard():Put("position", position)
    self:Success()
  else
    print(string.format("No position to set for %s", self:GetEntity():GetUnitName()))
  end
end

function DASetPositionAction:_DeterminePosition()
  print("DASetPositionAction:_DeterminePosition called. Did you forget to override it?")
end