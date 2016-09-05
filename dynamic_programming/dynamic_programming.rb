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
end
