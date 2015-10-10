
require("libraries/da/da_class_utils")

if DABlackboard == nil then 
  DABlackboard  = daDeclareClass({}, function(self)
    self:Reset()
  end)
end 

function DABlackboard:Reset()
  self._dataMap = {}
end

function DABlackboard:Put(key, value)
  self._dataMap[key] = value
end

function DABlackboard:Get(key)
  local value = self._dataMap[key]
  if value == nil then
    print(string.format("Failed to get blackboard value for %s", key))
  end
  return value
end
