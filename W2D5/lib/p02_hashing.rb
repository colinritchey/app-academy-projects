class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    key = 3
    result = 0

    each_with_index do |el, i|
      result += (el.hash^i.hash)
    end

    result
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash

    array_hash = self.map do |key, value|
      [key, value]
    end

    result = 0
    array_hash.each do |el|
      result += el[0].hash^el[1].hash
    end

    result

  end
end
