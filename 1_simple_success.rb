require "pbt"

# I know Ruby has Array#sort, but let's implement it ourselves.
# Note: This is not in-place quick sort.
def sort(array)
  return array if array.size <= 1
  pivot, *rest = array
  left, right = rest.partition { |n| n <= pivot }
  sort(left) + [pivot] + sort(right)
end

# Example based testing looks like this:
# RSpec.describe "sort" do
#   it "sorts an array" do
#     expect(sort([3, 1, 2])).to eq([1, 2, 3])
#     expect(sort([3, 1])).to eq([1, 3])
#     expect(sort([])).to eq([])
#   end
# end

# Property based testing
Pbt.assert(worker: :ractor) do
  Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
    result = sort(numbers)
    result.each_cons(2) do |x, y|
      raise "Sort algorithm is wrong." unless x <= y
    end
  end
end
