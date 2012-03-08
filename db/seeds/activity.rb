Activity.delete_all
20.times do |i|
  activity = Activity.new
  activity.group_id = rand_range(1..20)
  activity.title = Faker::Lorem.sentence(5)
  activity.description = Faker::Lorem.paragraph(10)
  activity.start_at = rand_range(100..200).hours.ago
  activity.end_at = rand_range(2..99).hours.ago
  activity.location = Faker::Lorem.sentence(2)
  activity.public = rand_range(1..2).odd?
  activity.poster = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
  #activity.banner = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
  activity.points = rand_range(1..100)
  activity.boss_id = rand_range(1..11)
  activity.save
end
