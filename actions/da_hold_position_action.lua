
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")
require("libraries/da/orders/da_hold_position_order")

if DAHoldPositionAction == nil then
  DAHoldPositionAction = daDeclareClass(DAAction, function(self)
    DAAction.init(self)
  end)
end

function DAHoldPositionAction:Execute()
  local entity = self:GetTree():GetEntity()
  local order = DAHoldPositionOrder(entity)
  order:IssueOrder()
  self:Success()
end