
require("libraries/da/da_class_utils")
require("libraries/da/orders/da_unit_order")

if DAMoveToTargetOrder == nil then
  DAMoveToTargetOrder = daDeclareClass(DAUnitOrder, function(self, orderedUnit, targetEntity)
    DAUnitOrder.init(self, orderedUnit)
    self._targetEntity = targetEntity
  end)
end

function DAMoveToTargetOrder:_CreateOrderTable()
  local moveToTargetOrder = {
    UnitIndex = self:GetOrderedUnit():entindex(),
    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
    TargetIndex = self._targetEntity:entindex()
  }
  return moveToTargetOrder
end