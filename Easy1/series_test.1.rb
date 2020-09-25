=begin
Divisors

Write a method that returns a list of all of the divisors of the 
positive integer passed in as an argument. 
The return value can be in any sequence you wish.


def divisors(num)
  1.upto(num).select do |number|
    num % number == 0
  end
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] 


decipher the names beloew using ROT13 N-Z = A-M and vice versa

Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu

each character indicated what the next should be
take the ordinal number of the character for a-mA-M and convert it to n-zN-Z
and same for N-Zn-z and subtract 13 from it

ENCRYPTED_PIONEERS = [
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
].freeze


  def rot13(encrypted_text)
    encrypted_text.each_char.reduce('') do |result, letter|
    result + decrypt_text(letter)
    end
  end

  def decrypt_text(letter)
    case letter
    when 'a'..'m', 'A'..'M' then (letter.ord + 13).chr
    when 'n'..'z', 'N'..'Z' then (letter.ord - 13).chr
    else letter
    end
  end
  
p  ENCRYPTED_PIONEERS.map { |word| rot13(word)}

Iterators: True for Any?

The Enumerable#any? method processes elements in a collection by passing 
each element value to a block that is provided in the method call. If the 
block returns a value of true for any element, then #any? returns true. 
Otherwise, #any? returns false. Note in particular that #any? will stop 
searching the collection the first time the block returns true.

Write a method called any? that behaves similarly for Arrays. It should 
take an Array as an argument, and a block. It should return true if the 
block returns true for any of the element values. Otherwise, it should 
return false.

Your method should stop processing elements of the Array as soon as the 
block returns true.

If the Array is empty, any? should return false, regardless of how the 
block is defined.

Your method may not use any standard ruby method that is named all?, 
any?, none?, or one?.

def any?(array)
  array.each do |num| 
    return true if yield(num)
  end
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false

Enumerable#all? processes elements in a collection by passing each 
element value to a block that is provided in the method call. 
If the block returns a value of true for every element, then #all? 
returns true. Otherwise, #all? returns false. Note in particular that 
#all? will stop searching the collection the first time the block returns
false.

Write a method called all? that behaves similarly for Arrays. It
should take an Array as an argument, and a block. It should return 
true if the block returns true for all of the element values. Otherwise, 
it should return false.

Your method should stop processing elements of the Array as soon as 
the block returns false.

If the Array is empty, all? should return true, regardless of how the 
block is defined.

Your method may not use any standard ruby method that is named all?,
any?, none?, or one?.
=end
def all?(array)
  array.each { |num| return false unless yield(num) }
  true
end
=begin
p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true

Write a method called none? that behaves similarly for Arrays. It should 
take an Array as an argument, and a block. It should return true if the 
block returns false for all of the element values. Otherwise, it should 
return false.

Your method should stop processing elements of the Array as soon as the 
block returns true.

If the Array is empty, none? should return true, regardless of how the 
block is defined.

Your method may not use any of the following methods from the Array and 
Enumerable classes: all?, any?, none?, one?. You may, however, use either
of the methods created in the previous two exercises.



def none?(array)
  array.each {|num| return false if yield(num)}
  true
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true

Write a method called one? that behaves similarly for Arrays. 
It should take an Array as an argument, and a block. It should 
return true if the block returns true for exactly one of the element
values. Otherwise, it should return false.

Your method should stop processing elements of the Array as soon as 
the block returns true a second time.

If the Array is empty, one? should return false, regardless of how 
the block is defined.
=end
def one?(array)
  one_true = false
  array.each {|num| 
  next unless yield(num)
  return false if one_true
  one_true = true
  }
  one_true
  
end

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }                     # -> false


def count(array)
  result = 0
  array.each do |num|
    result += 1 if yield(num)
  end
  result
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2