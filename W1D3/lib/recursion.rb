require 'byebug'

def range(start, end_point)
  return nil if end_point < start
  final_array = [start]
  return final_array if start == end_point

  final_array += range(start + 1, end_point)
end

# p range(-1, 4)

def sum_array_iterative(nums_array)
  nums_array.reduce(:+)
end

def sum_array_recursive(nums_array)
  return nums_array.first if nums_array.length <= 1
  nums_array.shift + sum_array_recursive(nums_array)
end

# p sum_array_recursive([1, 2, -1])

def exp(base, exponent)
  return 1 if exponent.zero?

  base * exp(base, exponent - 1)
end

# p exp(2, 0)
# p exp(3, 3)

def exp_ver_two(base, exponent)
  return 1 if exponent.zero?

  if exponent.even?
    n = exp_ver_two(base, exponent / 2)
    n * n
  else
    n = exp_ver_two(base, (exponent - 1) / 2)
    base * (n * n)
  end
end

# p exp_ver_two(2, 0)
# p exp_ver_two(3, 3)
# p exp_ver_two(2, 2)

def deep_dup(array)

  final_array = []
  return final_array if array.empty?

  array.each do |item|
    if item.is_a?(Array)
      final_array << deep_dup(item)
    else
      final_array << item
    end
  end

  final_array
end


def fibonacci(n)
  final_array = []

  if n == 1
    final_array << 1
    return final_array
  elsif n < 1
    return final_array
  end

  final_array = fibonacci(n - 1)
  a = fibonacci(n - 1)[-1]
  b = fibonacci(n - 2)[-1]

  if b.nil?
    final_array << a
  else
    final_array << a + b
  end
  final_array
end


# p fibonacci(9)

def subsets(array)
  final_array = []
  return [final_array] if array.length < 1
  # return [[], [array.first]] if array.length == 1

  last_index = array.index(array.last)

  set = subsets(array[0...last_index])
  appended_set = set.map do |item|
    item += [array.last]
  end

  p "set #{set}"
  p "appended_set #{appended_set}"

  final_array += set
  final_array += appended_set

  final_array
end

#p subsets([1,2])
# p subsets([1, 2, 3, 4]).length

def permutations(array)
  return array if array.length <= 1

  if array.length == 2
    return [array, array.reverse]
  end

  final_array = []

  array.length.times do
    set = array.take(array.length - 1)

    final_array += permutations(set).map do |item|
      item += [array.last]
    end

    next_item = array.shift
    array.push(next_item)
  end

  final_array
end

# p permutations([1, 2, 3, 4])
# p permutations([1, 2, 3, 4]).length

def bsearch(array, target)
  mid_point = array.length / 2

  return mid_point if target == array[mid_point]
  return nil if array.length == 1

  left_hand = array[0...mid_point]
  right_hand = array[mid_point..-1]

  if target < array[mid_point]
    bsearch(left_hand, target)
  else
    result = bsearch(right_hand, target)
    return nil if result.nil?
    mid_point + result
  end

end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(array)
  return array if array.length <= 1

  mid_point = array.length / 2

  left_hand = merge_sort(array.take(mid_point))
  right_hand = merge_sort(array.drop(mid_point))

  merge_sort_compare(left_hand, right_hand)
  #left_hand + right_hand
end

def merge_sort_compare(array1, array2)
  merged_array = []

  loop do
    break if array1.empty? || array2.empty?

    if array1.first < array2.first
      merged_array << array1.shift
    else
      merged_array << array2.shift
    end
  end

  merged_array + array1 + array2

end

# a = [1, 5, 3, 4]
# p merge_sort(a)

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  #debugger
  return [amount] if amount == 1
  return [] if coins.min > amount

  collected_coins = []

  coins.each do |coin|
    divided_amount = amount / coin

    if divided_amount > 0
      new_amount = amount - (coin * divided_amount)
      if new_amount == 0
        return collected_coins
      end

      divided_amount.times do
        collected_coins << coin
      end

      collected_coins += greedy_make_change(new_amount, coins)
    #elsif divided_amount ==

    end
  end

  collected_coins
end


def greedy_make_change_2(amount, coins = [25, 10, 5, 1])
  return 0 if coins.empty? || amount == 0
  return 1 if amount == 1
  collected_coins = []

  selected_coin = coins.shift
  #p selected_coin
  divided_amount = amount / selected_coin
  #p divided_amount
  if divided_amount > 0
    divided_amount.times do
      collected_coins << selected_coin
    end
    amount_collected = divided_amount * selected_coin
    collected_coins += greedy_make_change_2(amount - amount_collected, coins)
  else
    collected_coins += greedy_make_change_2(amount, coins)
  end
  collected_coins
end

# p greedy_make_change_2(24, [10, 7, 1]) #correct = 10, 7, 7
# p greedy_make_change_2(6, [5, 1])
