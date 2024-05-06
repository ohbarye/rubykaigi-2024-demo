require "pbt"

# I know Ruby has Array#sort, but let's implement it ourselves
# Note: This is not in-place quick sort
def sort(array)
  return array if array.size <= 2 # This is wrong!!!!!!!!!!!! It should be 1
  pivot, *rest = array
  left, right = rest.partition { |n| n <= pivot }
  sort(left) + [pivot] + sort(right)
end

RSpec.describe "RubyKaigi 2024 demo" do
  it "sorts an array" do
    Pbt.assert do
      Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
        result = sort(numbers)
        result.each_cons(2) do |x, y|
          expect(x).to be <= y
        end
      end
    end
  end
end
