Activity.delete_all
500.times do |i|
  activity = Activity.new
  activity.group_id = Random.rand(1..100)
  activity.title = Faker::Lorem.sentence(5)
  activity.description = Faker::Lorem.paragraph(10)
  activity.start_at = Random.rand(100..200).hours.ago
  activity.end_at = Random.rand(2..99).hours.ago
  activity.location_id = Random.rand(1..100)
  activity.public = Random.rand(1..2).odd?
  activity.poster = File.open(File.expand_path("../../pics/#{Random.rand(1..52)}.jpg", __FILE__))
  activity.points = Random.rand(1..100)
  activity.save!
end
