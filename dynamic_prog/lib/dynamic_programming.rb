class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 
      1 => [[1]], 
      2 => [[1, 1], [2]], 
      3 => [[1, 1, 1], [2, 1], [1, 2], [3]]
    }
  end

  def blair_nums(n)
    return 1 if n == 1
    return 2 if n == 2

    total = 0
    total += @blair_cache[n - 1] || blair_nums(n - 1)
    total += @blair_cache[n - 2] || blair_nums(n - 2)
    total += 2 * n - 3

    @blair_cache[n] = total
    total
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = { 
      1 => [[1]], 
      2 => [[1, 1], [2]], 
      3 => [[1, 1, 1], [2, 1], [1, 2], [3]]
    }
    return cache if n < 4

    (4..n).each do |i|
      cache[i] = cache[i - 1].map {|steps| steps.dup << 1} 
      cache[i] += cache[i - 2].map {|steps| steps.dup << 2}
      cache[i] += cache[i - 3].map {|steps| steps.dup << 3}
    end

    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if n < 4

    hops = @frog_cache[n - 1] ? @frog_cache[n - 1].map {|steps| steps.dup << 1} : frog_hops_top_down_helper(n - 1)
    hops += @frog_cache[n - 2] ? @frog_cache[n - 2].map {|steps| steps.dup << 2} : frog_hops_top_down_helper(n - 2)
    hops += @frog_cache[n - 3] ? @frog_cache[n - 3].map {|steps| steps.dup << 3} : frog_hops_top_down_helper(n - 3)

    @frog_cache[n] = hops
    hops
  end

  def super_frog_hops(n, k)
    cache = super_frog_cache_builder(n, k)
    cache[n]
  end

  def super_frog_cache_builder(n, k)
    cache = {
      1 => [[1]]
    }

    (2..n).each do |i|
      hops = []
      hops << [i] unless k < i
      
      (i - 1).downto(i - k < 1 ? 1 : i - k).each do |j|
        hops += cache[j].map {|steps| steps.dup << i - j}
      end

      cache[i] = hops
    end

    cache
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table[-1][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = []
    table << Array.new(values.length, 0)

    (1..capacity).each do |cap|
      vals = []
      
      weights.each_with_index do |weight, i|
        if weight > cap
          if vals.empty?
            vals << table[cap - 1][i]
          else
            max = vals[i - 1] > table[cap - 1][i] ? vals[i - 1] : table[cap - 1][i]
            vals << max
          end
        else
          next_val = table[cap - weight][i - 1] + values[i]

          if vals.empty?
            max = table[cap - 1][i] > values[i] ? table[cap - 1][i] : values[i]
            vals << max
          else
            max = next_val > vals[i - 1] ? next_val : vals[i - 1]
            vals << max
          end
        end
      end

      table << vals
    end

    table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
