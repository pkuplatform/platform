Profile.delete_all
100.times do |i|
  profile = Profile.new
  profile.user_id = i + 1
  profile.status = 4
  profile.name = Faker::Name.name
  profile.nickname = Faker::Name.name
  profile.gender = rand_range(1..2)
  profile.student_id = Faker::PhoneNumber.phone_number
  profile.phone = Faker::PhoneNumber.phone_number
  profile.points = rand_range(1..1000)
  profile.description = Faker::Lorem.paragraph(10)
  profile.avatar = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
  profile.save!
end
