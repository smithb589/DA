

-- Note that the array must be indexed by 1..n
function DAShuffle(array)
  local numberOfItems = #array
  for currentIndex=1,numberOfItems do
    local exchangeIndex = RandomInt(currentIndex, numberOfItems)
    local temp = array[currentIndex]
    array[currentIndex] = array[exchangeIndex]
    array[exchangeIndex] = temp
  end
  return array
end

function PrintVector(vector)
  print(string.format("<%f, %f, %f>", vector.x, vector.y, vector.z))
end

function VectorToString(vector)
  return string.format("<%f, %f, %f>", vector.x, vector.y, vector.z)
end