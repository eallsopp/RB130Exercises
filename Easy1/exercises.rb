=begin
From-To-Step Sequence Generator

The Range#step method lets you iterate over a range of values where each value 
in the iteration is the previous value plus a "step" value. It returns the original range.

Write a method that does the same thing as Range#step, but does not operate on a 
range. Instead, your method should take 3 arguments: the starting value, the 
ending value, and the step value to be applied to each iteration. Your 
method should also take a block to which it will yield (or call) successive iteration values


def step(begin_val, end_val, increment)
  value = begin_val
  until value > end_val
    yield(value)
    value += increment
  end
  value
end

step(1, 10, 3) { |value| puts "value = #{value}" } 

Zipper


def zip(array1, array2)
  max = array2.size - 1
  zipped_arr = []

  0.upto(max) do |num|
    zipped_arr << [array1[num], array2[num]]
  end
  
  zipped_arr
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]


#3 Write a map method


# def map(array)
#   array.each_with_object([]) { |num, arr| arr << yield(num) }
# end || 

def map(arr)
  Array.new(arr.size) { |i| yield(arr[i]) }
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

p map([1, 2, 3, 4]) { |val| val ** 3} == [1, 8, 27, 64]

#4 count

def count(*arguments)
  value = 0
  arr = arguments
  
  arr.each { |num| value += 1 if yield(num) }
  value
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3

# drop_while until the array hits the block, iterate though, r
# eturn the first instance of the block

def drop_while(arr)
  arr.each_with_index { |num, idx| return arr[idx..-1] unless yield(num) }
  []
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []

#each_with_index
def each_with_index(array)
  index = 0
  array.each do |num| yield(num, index)
    index += 1
  end
end

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]

# should output:
# 0 -> 1
# 1 -> 3
# 2 -> 36
# true


def each_with_object(array, obj)
  array.each do |num| yield(num, obj)
  end
  obj
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}

def max_by(array)
  var = array[0]
  array.each do |obj|
    if yield(obj) > yield(var)
    var = obj
    end
  end
  
  var
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil

each_cons

def each_cons(array)
  return nil if array.empty?
  index = 0
  loop do
    break if index == array.size - 1
    yield array[index], array[index + 1]
    index += 1
  end
  nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}
result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
result == nil

#each_cons2
#HAndle multiple elements at a time
=end

def each_cons(array, elements)
  index = 0
  loop do
    break if index + elements - 1 >= array.size
    yield(*array[index..(index + elements - 1)])
    index += 1
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}