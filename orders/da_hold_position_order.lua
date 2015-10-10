
require("libraries/da/orders/da_unit_order")

if DAHoldPositionOrder == nil then
    DAHoldPositionOrder = daDeclareClass(DAUnitOrder, function(self, orderedEntity)
        DAUnitOrder.init(self, orderedEntity)
    end)
end

-- Override this in derived order objects.
function DAHoldPositionOrder:_CreateOrderTable()
  local holdPositionOrder = {
    UnitIndex = self:GetOrderedUnit():entindex(), 
    OrderType = DOTA_UNIT_ORDER_HOLD_POSITION
  }
  return holdPositionOrder
end