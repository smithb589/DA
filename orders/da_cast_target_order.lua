
require("libraries/da/da_class_utils")

if DACastTargetOrder == nil then
  DACastTargetOrder = daDeclareClass(DAUnitOrder, function(self, orderedUnit, abilityIndex, targetUnit)
    DAUnitOrder.init(self, orderedUnit)
    self._targetIndex = targetUnit:entindex()
    self._abilityIndex = abilityIndex
  end)
end

function DACastTargetOrder:_CreateOrderTable()
  local castTargetOrder = {
    UnitIndex = self:GetOrderedUnitIndex(),
    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
    TargetIndex = self._targetIndex,
    AbilityIndex = self._abilityIndex
  }
  return castTargetOrder
end