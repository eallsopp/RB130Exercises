=begin
Optional Blocks

Write a method that takes an optional block. If the block is specified, the method 
should execute it, and return the value returned by the block. If no block is specified, 
the method should simply return the String 'Does not compute.'.

Examples:

    def compute(str, &block)
      return "Does not compute." unless block_given?
      yield(str)
    end

p compute('fun') { |str| "This is #{str}" }
p compute(4) {|num| num + num}
p compute(1)


Find Missing Numbers

Write a method that takes a sorted array of integers as an 
argument, and returns an array that includes all of the missing 
integers (in order) between the first and last element
s of the argument.

an array of values between x and y containa  sorte array
return an array containg the values tha tare missing

look at the one ahead of it, if it is the next in series skip
if it is not, add values between that and the next into an array
can use include?

iterate over the array
if the array includes nums between the array values, omit
if it desnt, retunr tha

Examples:

def missing(array)
 (array.first...array.last).reject {|num| array.include?(num)}
end
p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []


Divisors

Write a method that returns a list of all of the divisors of the 
positive integer passed in as an argument. 
The return value can be in any sequence you wish.
=end

def divisors(num)
  
end

divisors(1) == [1]
divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
