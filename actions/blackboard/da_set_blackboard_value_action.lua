
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")

if DASetBlackboardValueAction == nil then
  DASetBlackboardValueAction = daDeclareClass(DAAction, function(self, blackboardValueName, value)
    DAAction.init(self)
    self._blackboardValueName = blackboardValueName
    self._blackboardValue = value
  end)
end

function DASetBlackboardValueAction:Execute()
  if self._blackboardValueName then
    if self._blackboardValue ~= nil then
      self:GetBlackboard():Put(self._blackboardValueName, self._blackboardValue)
      self:Success()
    else
      print(string.format("No blackboard value to set for %s", self:GetEntity():GetUnitName()))
      self:Fail()
    end
  else
    print(string.format("No blackboard value name to set for %s", self:GetEntity():GetUnitName()))
    self:Fail()
  end
end
