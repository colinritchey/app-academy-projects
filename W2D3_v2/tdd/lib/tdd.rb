class Array

  def my_uniq
    self.each_with_object([]) do |el, result|
      result << el unless result.include?(el)
    end
  end

  def two_sum
    result = []
    each_with_index do |el, i|
      self[(i + 1)..-1].each_with_index do |subel, j|
        result << [i, j + i + 1] if el + subel == 0
      end
    end
    result
  end

  def my_transpose
    result = []

    (0...size).each do |i|
      sub_array = []

      self.each do |el|
        sub_array << el[i] unless el.empty?
      end

      result << sub_array unless sub_array.empty?
    end

    result
  end

end

def stock_picker(daily_prices)
  raise ArgumentError unless daily_prices.is_a?(Array)
  raise ArgumentError unless daily_prices.all?{|el| el.is_a?(Numeric)}
  return [] if daily_prices.size <= 1

  low, high = nil, nil
  largest_difference = 0

  daily_prices.each_with_index do |price, day|
    next_day = day + 1

    daily_prices[next_day..-1].each_with_index do |price_2, day_2|
      current_difference = price_2 - price

      if current_difference > largest_difference
        high = day_2 + next_day
        low = day
        largest_difference = current_difference
      end

    end
  end

  largest_difference > 0 ? [low, high] : []
end
