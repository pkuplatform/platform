require 'rubygems'
require 'rufus/scheduler'

=begin
scheduler = Rufus::Scheduler.start_new
scheduler.every('30s') do
  RankList.get_daily_rank
  puts "----------get daily rank-----------\n"
end

scheduler.every('30s') do
  RankList.get_weekly_rank
  puts "----------get weekly rank-----------\n"
end
=end
