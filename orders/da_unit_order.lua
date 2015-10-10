
--[[
Taken from the holdout example.

These are the valid orders, in case you want to use them (easier here than to find them in the C code):

DOTA_UNIT_ORDER_NONE
DOTA_UNIT_ORDER_MOVE_TO_POSITION 
DOTA_UNIT_ORDER_MOVE_TO_TARGET 
DOTA_UNIT_ORDER_ATTACK_MOVE
DOTA_UNIT_ORDER_ATTACK_TARGET
DOTA_UNIT_ORDER_CAST_POSITION
DOTA_UNIT_ORDER_CAST_TARGET
DOTA_UNIT_ORDER_CAST_TARGET_TREE
DOTA_UNIT_ORDER_CAST_NO_TARGET
DOTA_UNIT_ORDER_CAST_TOGGLE
DOTA_UNIT_ORDER_HOLD_POSITION
DOTA_UNIT_ORDER_TRAIN_ABILITY
DOTA_UNIT_ORDER_DROP_ITEM
DOTA_UNIT_ORDER_GIVE_ITEM
DOTA_UNIT_ORDER_PICKUP_ITEM
DOTA_UNIT_ORDER_PICKUP_RUNE
DOTA_UNIT_ORDER_PURCHASE_ITEM
DOTA_UNIT_ORDER_SELL_ITEM
DOTA_UNIT_ORDER_DISASSEMBLE_ITEM
DOTA_UNIT_ORDER_MOVE_ITEM
DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO
DOTA_UNIT_ORDER_STOP
DOTA_UNIT_ORDER_TAUNT
DOTA_UNIT_ORDER_BUYBACK
DOTA_UNIT_ORDER_GLYPH
DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH
DOTA_UNIT_ORDER_CAST_RUNE
]]


require("libraries/da/da_class_utils")

if DAUnitOrder == nil then 
  DAUnitOrder = daDeclareClass({}, function(self, orderedUnit)
    self._orderedUnit = orderedUnit
  end)
end

function DAUnitOrder:GetOrderedUnit()
  return self._orderedUnit
end

function DAUnitOrder:GetOrderedUnitIndex()
  return self._orderedUnit:entindex()
end

function DAUnitOrder:IssueOrder()
  local order = self:_CreateOrderTable()
  ExecuteOrderFromTable(order)
end

--[[
The "order" object
local newOrder = {
    UnitIndex = yourNPC:entindex(), 
    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
    TargetIndex = entToAttack:entindex(), --Optional.  Only used when targeting units
    AbilityIndex = 0, --Optional.  Only used when casting abilities
    Position = nil, --Optional.  Only used when targeting the ground
    Queue = 0 --Optional.  Used for queueing up abilities
  }
]]
-- Override this in derived order objects.
function DAUnitOrder:_CreateOrderTable()
  print("Creating a nil order table in DAUnitOrder. Did you forget to override _CreateOrderTable?")
  return nil
end