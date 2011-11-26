500.times do |i|
  activity = Activity.find(rand_range(1..100))
  user = User.find(rand_range(1..100))
  activity.comments.create(:title=>Faker::Lorem.sentence(5),:body=>Faker::Lorem.sentence(20),:user=>user)
end