#!/usr/bin/env ruby
# A regular expression to  match School by  accepting  one argument and pass it to a regular expression using matching method
puts ARGV[0].scan(/School/).join
