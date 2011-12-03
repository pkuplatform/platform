require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
=begin
scheduler.every('10s') do
  RankList.get_rank
  puts "----------get rank-----------\n"
end
=end
