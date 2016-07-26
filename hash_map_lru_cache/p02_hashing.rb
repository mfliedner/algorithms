class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    accumulator = 0
    self.each_with_index do |number, index|
      accumulator += number.hash * index
    end
    accumulator.hash
  end
end

class String
  def hash
    accumulator = 0
    self.each_byte.with_index do |byte, index|
      accumulator += byte.hash * index
    end
    accumulator.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  def hash
    accumulator = 0
    self.each do |key, value|
      accumulator += key.hash * value.hash
    end
    accumulator
  end
end
