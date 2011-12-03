require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
=begin

scheduler.every('1h') do
  RankList.get_rank
  puts "----------get rank-----------\n"
end
=end
