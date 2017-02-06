def permutation(str)
  return [str] if str.length <= 1
  result = []

  added_letter = str[0]
  perms = permutation(str[1..-1])

  perms.each do |perm|
    (0...str.length).each do |i|
      result << perm[0...i] + added_letter + perm[i..-1]
    end
  end

  result
end

def first_anagram?(str_one, str_two) # => O(n * n!)
  perms = permutation(str_one)
  perms.include?(str_two)
end

def second_anagram?(str_one, str_two) # => O(n^2)
  return false unless str_one.length == str_two.length
  letters_two = str_two.chars
  str_one.chars.each do |x|
    if letters_two.include?(x)
      letters_two.delete(x)
    end
  end
  letters_two.empty?
end

def third_anagram?(str_one, str_two) # => O(n * logn)
  str_one.chars.sort == str_two.chars.sort
end

def fourth_anagram?(str_one, str_two) # => O(n)
  res_hash_one = create_hash(str_one)
  res_hash_two = create_hash(str_two)

  res_hash_one == res_hash_two
end

def create_hash(str)
  res_hash = {}

  str.chars.each do |el|
    if res_hash.include?(el)
      res_hash[el] += 1
    else
      res_hash[el] = 1
    end
  end

  res_hash
end

p fourth_anagram?("hello", "orleh")
