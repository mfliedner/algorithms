class DPProblems
  def initialize
    # cache instance variables for each problem

    # first two members of Fibonacci series
    @fibonacci_cache = {1 => 1, 2 => 1}
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
end
