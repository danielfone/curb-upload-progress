#!/usr/bin/env ruby

require 'curb'

url = ARGV.shift or fail("USAGE: #{$0} URL")

curl = Curl::Easy.new url

curl.on_progress do |_, _, total, uploaded|
  next true if total == 0
  percent =  uploaded / total * 100
  print "\r#{percent.round}%\t(#{uploaded}/#{total})"
  true
end

# Generate a 1 Mb junk file
file_field = Curl::PostField.content('myfile') { 'a' * 1024 * 1024 }

puts "Uploading to #{url}"
curl.http_post file_field
puts
