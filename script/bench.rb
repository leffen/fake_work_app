require "socket"
require "csv"
require "yaml"
require "optparse"


def bench(port,path,iterations,concurrent)
  puts "Running apache bench warmup"
  `ab -n 10 "http://127.0.0.1:#{port}#{path}"`
  puts "Benchmarking #{path}"
  `ab -n #{iterations} -c #{concurrent} -e tmp/ab.csv "http://127.0.0.1:#{port}#{path}"`

  percentiles = Hash[*[50, 75, 90, 99].zip([]).flatten]
  CSV.foreach("tmp/ab.csv") do |percent, time|
    percentiles[percent.to_i] = time.to_i if percentiles.key? percent.to_i
  end

  percentiles
end


results = bench 3030,'/fake_work',500,10
puts "---"
puts results