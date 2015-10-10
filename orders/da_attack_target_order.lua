
require("libraries/da/da_class_utils")
require("libraries/da/orders/da_unit_order")

if DAAttackTargetOrder == nil then
  DAAttackTargetOrder = daDeclareClass(DAUnitOrder, function(self, orderedUnit, targetUnit)
    DAUnitOrder.init(self, orderedUnit)
    self._targetUnit = targetUnit
  end)
end

function DAAttackTargetOrder:_CreateOrderTable()
  local attackTargetOrderTable = {
    UnitIndex = self:GetOrderedUnitIndex(),
    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
    TargetIndex = self._targetUnit:entindex()
  }
  return attackTargetOrderTable
end
