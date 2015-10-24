
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")
require("libraries/da/orders/da_attack_target_order")

if DAAttackTargetAction == nil then
  DAAttackTargetAction = daDeclareClass(DAAction, function(self, blackboardTargetName)
    DAAction.init(self)

    self._blackboardTargetName = blackboardTargetName
  end)
end

function DAAttackTargetAction:PrepareToExecute()
  if self._blackboardTargetName then
    self._target = self:GetBlackboard():Get(self._blackboardTargetName)
  else
    print(string.format("No target name set for %s.", self:GetEntity():GetUnitName()))
  end
end

function DAAttackTargetAction:Execute()
  if self._target then
    local attackOrder = DAAttackTargetOrder(self:GetEntity(), self._target)
    attackOrder:IssueOrder()
    self:Success()
  else
    if self:IsDebugOutputEnabled() then
      print(string.format("No target set for %s in DAAttackTargetAction:Execute", self:GetEntity():GetUnitName()))
    end
    self:Fail()
  end
end

function DAAttackTargetAction:FinishedExecuting()
  self._target = nil
end

function DAAttackTargetAction:OutputSuccessMessage()
  print(string.format("Ordered %s to attack %s.", self:GetEntity():GetUnitName(), self._target:GetUnitName()))
end

function DAAttackTargetAction:OutputFailMessage()
  print(string.format("Could not order %s to attack target.", self:GetEntity():GetUnitName()))
end
