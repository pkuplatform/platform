Group.delete_all
100.times do |i|
  group = Group.new
  group.category_id = Random.rand(1..8)
  group.name = Faker::Company.name
  group.slogan = Faker::Company.catch_phrase
  group.description = Faker::Lorem.paragraph(10)
  group.history = Faker::Lorem.paragraph(10)
  group.organization = Faker::Lorem.paragraph(10)
  group.email = Faker::Internet.free_email
  group.status = Random.rand(1..3)
  group.points = Random.rand(100..1000)
  group.logo = File.open("../pics/#{Random.rand(1..52)}.jpg")
  group.save!
end
