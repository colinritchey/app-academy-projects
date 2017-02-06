def bad_two_sum?(arr, target) # => O(n^2)
  i = 0
  while i < arr.length
    j = i + 1
    while j < arr.length
      return true if arr[i] + arr[j] == target
      j += 1
    end
    i += 1
  end
  false
end

def b_search(array, target)
  return nil if array.empty?

  probe_index = array.length / 2
  left = array[0...probe_index]
  right = array[probe_index + 1 ..-1]

  case target <=> array[probe_index]
  when -1
    b_search(left, target)
  when 0
    probe_index
  when 1
    res = b_search(right, target)
    res.nil? ? nil : res + probe_index + 1
  end
end

def okay_two_sum?(arr, target) # => O(n * log(n))
  arr.sort.each_with_index do |el, i|
    value = target - el
    j = b_search(arr, value)
    return true unless i == j || j.nil?
  end
  false
end

def hash_map(arr, target) # => O(n)
  array_hash = {}

  arr.each_with_index do |el, index|
    value = target - el
    array_hash[el] = value
  end

  array_hash.each do |k, v|
    return true if array_hash.has_key?(v)
  end

  false
end

p hash_map(arr, 6)
