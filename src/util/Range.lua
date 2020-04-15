-- limited range function
return function (to)
  local nums = {}
  for i = 1, to do
    table.insert(nums, i)
  end
  return nums
end