
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")
require("libraries/da/orders/da_move_to_target_order")

if DAFollowNearestAllyAction == nil then
  DAFollowNearestAllyAction = daDeclareClass(DAAction, function(self)
    self._nearestAlly = nil
  end)
end

function DAFollowNearestAllyAction:PrepareToExecute()
  local entity = self:GetTree():GetEntity()
  local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
                                  entity:GetAbsOrigin(),
                                  nil,
                                  1000.0,
                                  DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                  DOTA_UNIT_TARGET_ALL,
                                  0,
                                  FIND_CLOSEST,
                                  false)
  self._nearestAlly = units[2]
end

function DAFollowNearestAllyAction:Execute()
  if self._nearestAlly ~= nil then
    local order = DAMoveToTargetOrder(self:GetTree():GetEntity(), self._nearestAlly)
    order:IssueOrder()
    self:Success()
  else
    self:Fail()
  end
end

function DAFollowNearestAllyAction:FinishedExecuting()
  self._nearestAlly = nil
end
