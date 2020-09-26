#1 Listening Device
#given..
=begin
class Device
  attr_reader :recordings
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end
end

#Anything that is said is retrieved by this listening device via a block. 
# If nothing is said, then no block will be passed in. 
# The listening device can also output the most recent recording using a Device#play method.
class Device
  attr_reader :recordings
  def initialize
    @recordings = []
  end
  
  def listen
    record(yield) if block_given?
  end

  def play
    puts recordings.last
  end

  def record(recording)
    @recordings << recording
  end
end
listener = Device.new
p listener.listen { "Hello World!" }
p listener.listen
p listener.play # Outputs "Hello World!"


# Paragraphs, lines and words
# deliniate between the 3
# split at new lines x2? for a paragraph
# split at new lines
# split at ' '

# Text Analyzer - Sandwich Code
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r') #open 
    yield(file.read)
    file.close #always close when finished!
  end
end

# sample output
# 3 paragraphs
# 15 lines
# 126 words

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{file.split("\n\n").count} paragraphs" }
analyzer.process { |file| puts "#{file.split("\n").count} lines" }
analyzer.process { |file| puts "#{file.split(' ').count} words"}

#PAssing Parameters Part 1

items = ['apples', 'corn', 'cabbage', 'wheat']

# def gather(items)
#   puts "Let's start gathering food."
#   puts "#{items.join(', ')}"
#   puts "Nice selection of food we have gathered!"
# end
# Modify the method  so that the display/output of items is moved to a block, 
# and its implementation is left up to the user of the gather method.

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(items) { |array| puts array.join(', ') }


#Passing Parameters Part 2
# write a method that takes an array as an argument. 
# The method should yield the contents of the array to a block, which should 
# assign your block variables in such a way that it ignores the first two 
# elements, and groups all remaining elements as a raptors array.

array = %w(raven finch hawk eagle)

def animals(array)
  yield(array)
end

animals(array) do |array| *raptors = array[-2..-1] 
puts "Raptors: #{raptors.join(', ')}" end


#Passing Parameters 3
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# Fill out the following method calls for gather so that they produce the 
# corresponding output shown in numbers 1-4 listed below:
#1
gather(items) do | item , _ |
  puts "#{items[0..-2].join(', ')}"
  puts "#{items[-1]}"
end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

#2
gather(items) do | first, *middle, last |
  puts "#{first}"
  puts "#{middle.join(', ')}"
  puts "#{last}"
end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

#3
gather(items) do | first,*remaining |
  puts "#{first}"
  puts "#{remaining.join(', ')}"
end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

#4
gather(items) do | f,s ,t ,last |
  puts "#{f}, #{s}, #{t}, #{last}"
end
=end


#Method to Proc
# Consider this:
# comparator = proc { |a, b| b <=> a }

# def convert_to_base_8(n)
#   n.method_name.method_name # replace these two method calls
# end

# The correct type of argument must be used below
# base8_proc = method(argument).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
# [8, 10, 12, 14, 16, 33].map(&a_proc)

def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8).to_proc
#aka Proc.new { |n| n.to_s(8).to_i }

p [8, 10, 12, 14, 16, 33].map(&base8_proc)

#bubble sort with Blocks
# In an earlier exercise, you were asked to construct a #bubble_sort! method that 
# used the bubble sort algorithm to sort Arrays in place. Our solution was this:

# def bubble_sort!(array)
#   loop do
#     swapped = false
#     1.upto(array.size - 1) do |index|
#       next if array[index - 1] <= array[index]
#       array[index - 1], array[index] = array[index], array[index - 1]
#       swapped = true
#     end

#     break unless swapped
#   end
#   nil
# end
# The problem is tat you have no freedom to adjust this. Restructure it to 
# take a block as an argument to change the sequence at the beest of the invoker.

def bubble_sort!(array)
  loop do
    
    swapped = false
    
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end
      
      array[index - 1], array[index] = array[index], array[index - 1] 
      swapped = true
    end

    break unless swapped
  end
  nil
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)