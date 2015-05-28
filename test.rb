plaintext = 'hello'
generalknap = [2, 3, 7, 14, 30, 57, 120, 251]

require './modular_arithmetic.rb'
require './knapsack_cipher.rb'
m = 41
n = 491

#binary = plaintext.chars.map { |e| e.ord.to_s(2) }
binary = plaintext.each_byte.map {|y| sprintf "%08b", y}
puts binary
#convert to int http://stackoverflow.com/questions/781054/convert-an-array-of-integers-into-an-array-of-strings-in-ruby
binary = binary.map { |e| e.split('').map(&:to_i) }

#binary = binary.map { |i| i.to_i }
#puts binary.join()
# add sum of product of arrays http://rosettacode.org/wiki/Sum_and_product_of_an_array
binary = binary.map { |x|  x.zip(generalknap).map { |x,y| x * y }.inject(0,:+) }

#binary = binary.map { |x,y| x * y }
#puts binary.join()
puts binary
#binary = binary.
######
puts "End Encrypt"
modinverse = ModularArithmetic.invert(m, n)
decipher = binary.map { |e| e * modinverse % n }
puts decipher

superknap = generalknap.reverse
puts superknap.join(" ")

#decipher = decipher.map do |var|
	
#end


  def self.solve(num, superknap)
    number = superknap.map do |variable|
        if num >= variable
        	num = num - variable
        	1
        else
        	0
        end
    end.reverse.join
    number.to_i(2).chr
  end

decipher = decipher.map { |e| solve(e, superknap) }
puts decipher.join()











