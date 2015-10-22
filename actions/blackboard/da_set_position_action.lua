
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

-- Sets the blackboard position from an offset of the current position
if DASetPositionAction == nil then
  DASetPositionAction = daDeclareClass(DAAction, function(self, blackboardValueName)
    DAAction.init(self)
    self._blackboardValueName = blackboardValueName
  end)
end

function DASetPositionAction:Execute()
  local position = self:_DeterminePosition()
  if position then
    if self._blackboardValueName then
      self:GetBlackboard():Put(self._blackboardValueName, position)
      self:Success()
    else
      print(string.format("No blackboard value name to use for %s", self:GetEntity():GetUnitName()))
      self:Fail()
    end
  else
    print(string.format("No position to set for %s", self:GetEntity():GetUnitName()))
    self:Fail()
  end
end

function DASetPositionAction:_DeterminePosition()
  print("DASetPositionAction:_DeterminePosition called. Did you forget to override it?")
end