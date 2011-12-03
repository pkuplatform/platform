require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every('30s') do
  RankList.get_rank
  puts "----------get rank-----------\n"
end
