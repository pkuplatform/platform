Group.delete_all
100.times do |i|
  group = Group.new
  group.category_id = rand_range(1..8)
  group.name = Faker::Company.name
  group.slogan = Faker::Company.catch_phrase
  group.description = Faker::Lorem.paragraph(10)
  group.history = Faker::Lorem.paragraph(10)
  group.organization = Faker::Lorem.paragraph(10)
  group.email = Faker::Internet.free_email
  group.status = rand_range(0..3)
  group.points = rand_range(100..1000)
  group.logo = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
  group.save
end
