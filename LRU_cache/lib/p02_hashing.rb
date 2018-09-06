class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    
    self.each_with_index do |el, idx|
      result += (el.object_id * idx.object_id) ** 3
    end
    
    result.hash
  end
end

class String
  def hash
    result = 0
    
    self.each_byte.with_index do |c, idx|
      result += (c.object_id * idx.object_id) ** 3
    end
    
    result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.sort.map { |el| el.to_s.hash }.hash
  end
end