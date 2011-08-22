def time(&block)
  require 'benchmark'
  result = nil
  timing = Benchmark.measure do
    result = block.call
  end
  puts "It took: #{timing}"
  result
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 9000
