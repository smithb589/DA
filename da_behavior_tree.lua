
--[[
A decision tree that evaluates its subtasks to determine what action an
entity should take
]]

require("libraries/da/da_class_utils")
require("libraries/da/da_task")
require("libraries/da/da_blackboard")

if DABehaviorTree == nil then
  DABehaviorTree = daDeclareClass(DATask, function(self, entity, rootTask)
    DATask.init(self)
    self._rootTask = rootTask
    self._taskStatus = TASK_SUCCESSFUL
    self._entity = entity
    self._debugOutputEnabled = false
    self._running = false
    self._blackboard = DABlackboard()

    self._entity.ddBehaviorTree = self

    self:SetTree(self)
    self._rootTask:SetTree(self)
    self._rootTask:SetParent(self)
  end)
end

function DABehaviorTree:GetEntity()
  return self._entity
end

function DABehaviorTree:GetBlackboard()
  return self._blackboard
end

function DABehaviorTree:SetDebugOutputEnabled(enabled)
  self._debugOutputEnabled = enabled
end

function DABehaviorTree:IsDebugOutputEnabled()
  local debugOutputEnabled = self._debugOutputEnabled

  if self:GetTree() ~= self then
    debugOutputEnabled = self:GetTree():IsDebugOutputEnabled()
  end

  return debugOutputEnabled
end

function DABehaviorTree:PrepareToExecute()
  self._taskStatus = TASK_SUCCESSFUL
  self._running = true
end

function DABehaviorTree:FinishedExecuting()
  self._running = false
end

function DABehaviorTree:Step()
  if not self._running then
    self:PrepareToExecute()
  end

  self:Execute()

  if self._taskStatus ~= TASK_RUNNING then
    self:FinishedExecuting()
  end
end

function DABehaviorTree:Execute()
  if self._taskStatus ~= TASK_RUNNING then
    self._rootTask:PrepareToExecute()
    self._taskStatus = TASK_RUNNING
  end

  self._rootTask:Execute()
end

function DABehaviorTree.GetBehaviorTreeFromEntity(entity)
  local tree = (entity ~= nil) and entity.ddBehaviorTree or nil
  if not tree and entity then
    print(string.format("No behavior tree found on unit %s.", entity:GetUnitName()))
  elseif not entity then
    print("Attempted to get behavior tree for nil entity.")
  end

  return tree
end

function DABehaviorTree:HandleChildFailure(childTask)
  self._taskStatus = TASK_FAILED
  self:Fail()
end

function DABehaviorTree:HandleChildSuccess(childTask)
  self._taskStatus = TASK_SUCCESSFUL
  self:Success()
end