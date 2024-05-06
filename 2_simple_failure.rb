require "pbt"

# I know Ruby has Array#sort, but let's implement it ourselves
# Note: This is not in-place quick sort
def sort(array)
  return array if array.size <= 2 # This is wrong!!!!!!!!!!!! It should be 1
  pivot, *rest = array
  left, right = rest.partition { |n| n <= pivot }
  sort(left) + [pivot] + sort(right)
end

# Try with `seed: xxx`.
# Try with `verbose: true`.
# Try with `worker: :ractor, :thread, :process`.
Pbt.assert do
  Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
    result = sort(numbers)
    result.each_cons(2) do |x, y|
      raise "Sort algorithm is wrong." unless x <= y
    end
  end
end
