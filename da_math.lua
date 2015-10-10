
function DALength2DBetweenVectors(vector1, vector2)
  local difference = vector1 - vector2
  return difference:Length2D()
end

function DACompareFloats(float1, float2, tolerance)
    local difference = float1 - float2
    local equal = false
    if difference < 0 then
      equal = -difference < tolerance
    else
      equal = difference < tolerance
    end
    return equal
end

function DACompareVectors(vector1, vector2, tolerance)
  local xsEqual = DACompareFloats(vector1.x, vector2.x, tolerance)
  local ysEqual = DACompareFloats(vector1.y, vector2.y, tolerance)
  local zsEqual = DACompareFloats(vector1.z, vector2.z, tolerance)
  return xsEqual and ysEqual and zsEqual
end

function DACompareVectors2D(vector1, vector2, tolerance)
  local xsEqual = DACompareFloats(vector1.x, vector2.x, tolerance)
  local ysEqual = DACompareFloats(vector1.y, vector2.y, tolerance)
  return xsEqual and ysEqual
end

function DotProduct2D(vector1, vector2)
  local dotProduct = (vector1.x * vector2.x) + (vector1.y * vector2.y)
  return dotProduct
end