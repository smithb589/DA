
require("libraries/da/da_class_utils")
require("libraries/da/actions/da_action")
require("libraries/da/da_math")
require("libraries/da/da_constants")
require("libraries/da/da_utils")

if DAMoveToPositionAction == nil then
  DAMoveToPositionAction = daDeclareClass(DAAction, function(self, blackboardValueName)
    DAAction.init(self)

    self._blackboardValueName = blackboardValueName
    self._currentDestination = nil
    self._lastPosition = nil
    self._stoppedMovingTime = 0
    self._stoppedMoving = false
    self._lastPathCheckTime = 0
    self._lastForwardVector = nil
  end)
end

function DAMoveToPositionAction:PrepareToExecute()
  self._stoppedMovingTime = 0
  self._lastPathCheckTime = 0
  self._currentDestination = self:GetBlackboard():Get(self._blackboardValueName)
  if self._currentDestination then
    local entity = self:GetEntity()
    self._lastPosition = entity:GetAbsOrigin()
    self._lastForwardVector = entity:GetForwardVector()
    if self:_CanFindPath(self._lastPosition) then
      entity:MoveToPosition(self._currentDestination)
    end
    --print(string.format("Moving to position: %s", VectorToString(self._currentDestination)))
  end
end

function DAMoveToPositionAction:Execute()
  local entity = self:GetEntity()
  local currentPosition = entity:GetAbsOrigin()
  local reachedDestination = DACompareVectors2D(currentPosition, self._currentDestination, VECTOR_COMPARE_TOLERANCE)
  --PrintVector(currentPosition)
  --PrintVector(self._currentDestination)

  if reachedDestination then
    self:Success()
  elseif self:_IsMovementInterrupted(currentPosition) then
    if self:IsDebugOutputEnabled() then
      print("movement failed.")
      print(string.format("Compare vectors returns: %s", tostring(DACompareVectors2D(currentPosition, self._currentDestination, VECTOR_COMPARE_TOLERANCE))))
    end
    self:GetEntity():Stop()
    self:Fail()
  else
    -- if self:IsDebugOutputEnabled() then
    --   self:_OutputDebugRunningInformation(currentPosition)
    -- end
    self._lastPosition = entity:GetAbsOrigin()
    self._lastForwardVector = entity:GetForwardVector()
  end
end

function DAMoveToPositionAction:FinishedExecuting()
  self._currentDestination = nil
  self._lastPosition = nil
  self._stoppedMovingTime = 0
  self._stoppedMoving = false
  self._lastPathCheckTime = 0
  self._lastForwardVector = nil
end

function DAMoveToPositionAction:_IsMovementInterrupted(currentPosition)
  local canFindPath = self:_CanFindPath(currentPosition)
  local stoppedMoving = self:_StoppedMoving(currentPosition)
  local isTurning = self:_IsTurning()
  local movementInterrupted = not canFindPath or (stoppedMoving and not isTurning)
  if movementInterrupted and self:IsDebugOutputEnabled() then
    print(string.format("Can find path: %s", tostring(canFindPath)))
    print(string.format("Stopped moving: %s", tostring(stoppedMoving)))
    print(string.format("Is turning: %s", tostring(isTurning)))
    print(string.format("movementInterrupted: %s", tostring(movementInterrupted)))
  end
  return movementInterrupted
end

function DAMoveToPositionAction:_StoppedMoving(currentPosition)
  local positionUnchanged = DACompareVectors2D(currentPosition, self._lastPosition, VECTOR_COMPARE_TOLERANCE)
  local stoppedMoving = false
  if positionUnchanged and not self._stoppedMoving then
    self._stoppedMovingTime = GameRules:GetGameTime()
    self._stoppedMoving = true
  elseif positionUnchanged and self._stoppedMoving then
    -- Imperfect, but if we haven't moved for a second, we're likely stuck.
    if self._stoppedMovingTime < (GameRules:GetGameTime() - 1) then
      stoppedMoving = true
    end
  else
    self._stoppedMovingTime = 0
    self._stoppedMoving = false
  end

  if stoppedMoving and self:IsDebugOutputEnabled() then
    print(string.format("Distance to destination: %f", (currentPosition - self._currentDestination):Length2D()))
  end

  return stoppedMoving
end

function DAMoveToPositionAction:_IsTurning()
  local currentForward = self:GetEntity():GetForwardVector()
  local similarity = DotProduct2D(currentForward, self._lastForwardVector)
  return similarity < 0.99
end

function DAMoveToPositionAction:_CanFindPath(currentPosition)
  local canFindPath = true
  -- Only check once/sec
  if self._lastPathCheckTime < (GameRules:GetGameTime() - 1) then
    canFindPath = GridNav:CanFindPath(currentPosition, self._currentDestination)
    self._lastPathCheckTime = GameRules:GetGameTime()
  end
  return canFindPath
end

function DAMoveToPositionAction:_OutputDebugRunningInformation(currentPosition)
  local messageFormat = "Continuing movement for %s. CurrentPosition: %s, Destination: %s"
  local unitName = self:GetEntity():GetUnitName()
  local currentPositionString = VectorToString(currentPosition)
  local destinationString = VectorToString(self._currentDestination)
  print(string.format(messageFormat, unitName, currentPositionString, destinationString))
end