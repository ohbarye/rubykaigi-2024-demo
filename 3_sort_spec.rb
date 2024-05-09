require "pbt"

# I know Ruby has Array#sort, but let's implement it ourselves
# Note: This is not in-place quick sort
def sort(array)
  return array if array.size <= 1
  pivot, *rest = array
  left, right = rest.partition { |n| n <= pivot }
  sort(left) + [pivot] + sort(right)
end

# Try with options for `Pbt.assert`
#  worker: :ractor, experimental_ractor_rspec_integration: true
RSpec.describe "RubyKaigi 2024 demo" do
  it "sorts an array" do
    Pbt.assert do
      Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
        result = sort(numbers)
        result.each_cons(2) do |x, y|
          expect(x <= y).to eq true
        end
      end
    end
  end
end
