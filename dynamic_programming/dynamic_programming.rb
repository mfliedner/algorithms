class DPProblems
  def initialize
    # cache instance variables for each problem
    @fibonacci_cache = {1 => 1, 2 => 1} # first two members of Fibonacci series
    @coin_cache = {0 => 0} # base case: change for 0
    @knapsack_cache = [] # empty table
  end

  # Takes in a positive integer n and returns the nth Fibonacci number
  # Should run in O(n) time
  def fibonacci(n)
    return @fibonacci_cache[n] if @fibonacci_cache[n]
    next_fib = fibonacci(n-1) + fibonacci(n-2)
    @fibonacci_cache[n] = next_fib
    next_fib
  end

  # Takes in an amount and a set of coins (array sorted in ascending order).
  # Returns the minimum number of coins needed to make change for the given amount.
  # Assumes an unlimited supply of each type of coin.
  # Returns nil if it's not possible to make change for a given amount.
  def make_change(amt, coins)
    return @coin_cache[amt] if @coin_cache[amt]
    return nil if amt < coins[0]

    change = amt
    success = false
    (0...coins.length).each do |index|
      break if coins[index] > amt # no change possible

      count = nil
      # make change with one coins[idx] and figure out the rest recursively
      rest = make_change(amt - coins[index], coins)
      count = 1 + rest if rest


      unless count.nil?
        success = true
        change = count if count < change # kepp track of minimum
      end
    end

    # update cache
    if success
      @coin_cache[amt] = change
    else
      @coin_cache[amt] = nil
    end
  end

  # Knapsack Problem: takes in an array of weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight constraint.
  # Each item can only be included once.
  # Iterative, top-down solution
  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0

    # build cache table for all capacities and item weights with maximum value
    # using only first i items and weight constraint j
    (0..capacity).each do |i|
      @knapsack_cache[i] = []
      (0...weights.length).each do |j|
        if i == 0
          @knapsack_cache[i][j] = 0
        elsif j == 0
          @knapsack_cache[i][j] = weights[0] > i ? 0 : values[0]
        else
          # add item i if possible
          case1 = i < weights[j] ? 0 : @knapsack_cache[i - weights[j]][j - 1] + values[j]
          # do not add item i
          case2 = @knapsack_cache[i][j - 1]
          @knapsack_cache[i][j] = [case1, case2].max
        end
      end
    end

    @knapsack_cache[capacity][weights.length - 1]
  end
end
