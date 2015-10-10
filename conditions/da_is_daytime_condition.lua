
require("libraries/da/da_class_utils")
require("libraries/da/conditions/da_condition")

if DAIsDaytimeCondition == nil then
  DAIsDaytimeCondition = daDeclareClass(DACondition, function(self)
    DACondition.init(self)
  end)
end

function DAIsDaytimeCondition:Execute()
  if not GameRules:IsDaytime() then
    self:Fail()
  else
    self:Success()
  end
end

