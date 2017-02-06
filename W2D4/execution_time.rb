def my_min(list)
  smallest = nil

  list.each do |el|
    smallest = el if list.all?{ |sub_el| sub_el >= el}
  end

  smallest
end

list = [2, 3, -6, 7, -6, 7]

def my_min_v2(list)
  smallest = list.first

  list.each do |el|
    smallest = el if el < smallest
  end

  smallest
end

def subsets(array)
  res = []
  i = 0
  while i < array.length
    j = i + 1
    while j <= array.length
      res << array[i...j]
      j += 1
    end
    i += 1
  end
  res
end

def subs_sum(subsets)
  max_sum = 0
  subsets.each do |set|
    sum = set.reduce(:+)
    max_sum = sum if sum > max_sum
  end
  max_sum
end

def sub_sum_v2(array)
  max_sum = 0
  current_sum = 0

  array.each do |el|
    current_sum += el

    max_sum = current_sum if current_sum > max_sum

    current_sum = 0 if current_sum < 0
  end

  max_sum
end
