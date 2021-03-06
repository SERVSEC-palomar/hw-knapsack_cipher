require 'prime'
require './modular_arithmetic.rb'

class SuperKnapsack
  attr_accessor :knapsack

  def self.array_sum(arr)
    arr.reduce (:+)
  end

  def initialize(arr)
    arr.each.with_index do |a, i|
      unless i==0
        if (a <= self.class.array_sum(arr[0..i-1])) then
          raise(ArgumentError, "not superincreasing at index #{i}")
        end
      end
      @knapsack = arr
    end
  end

  def primes?(m,n)
    return Prime.prime?(m) && Prime.prime?(n)
  end

  def to_general(m, n)
    argError = "arguments must both be prime" if (!primes?(m,n))
    argError = "#{n} is smaller than superincreasing knapsack" if n <= @knapsack.last
    raise(ArgumentError, argError) unless argError.nil?
    @knapsack.map {|a| (a*m)%n }
  end
end

class KnapsackCipher
  # Default values of knapsacks, primes
  M = 41
  N = 491
  DEF_SUPER = SuperKnapsack.new([2, 3, 7, 14, 30, 57, 120, 251])
  DEF_GENERAL = DEF_SUPER.to_general(M, N)

  # Encrypts plaintext
  # Params:
  # - plaintext: String object to be encrypted
  # - generalknap: Array object containing general knapsack numbers
  # Returns:
  # - Array of encrypted numbers
  def self.encrypt(plaintext, generalknap=DEF_GENERAL)
    # TODO: implement this method
    #convert to binary
    binary = plaintext.each_byte.map {|y| sprintf "%08b", y}
    binary = binary.map { |e| e.split('').map(&:to_i) }
    sum = binary.map { |x|  x.zip(generalknap).map { |x,y| x * y }.inject(0,:+) }
    sum
  end

  # Decrypts encrypted Array
  # Params:
  # - cipherarray: Array of encrypted numbers
  # - superknap: SuperKnapsack object
  # - m: prime number
  # - n: prime number
  # Returns:
  # - String of plain text
  def self.decrypt(cipherarray, superknap=DEF_SUPER, m=M, n=N)
    raise(ArgumentError, "Argument should be a SuperKnapsack object"
      ) unless superknap.is_a? SuperKnapsack

    # TODO: implement this method
    superknap = superknap.knapsack.reverse
    modinverse = ModularArithmetic.invert(m, n)
    decipher = cipherarray.map { |e| e * modinverse % n }
    decipher = decipher.map { |e| solve(e, superknap)  }.join
  end

  #Solving superincreasing knapscack 
  
  def self.solve( num, superknap )
    number = superknap.map do |variable|
      if num >= variable
          num = num - variable
          1
        else
          0
        end
    end.reverse.join
    char = number.to_i(2).chr
  end


end






