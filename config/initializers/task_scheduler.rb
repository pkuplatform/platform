require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every('24h') do
  RankList.get_daily_rank
  puts "----------get daily rank-----------\n"
end

scheduler.every('7d') do
  RankList.get_weekly_rank
  puts "----------get daily rank-----------\n"
end
