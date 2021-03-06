Group.delete_all
20.times do |i|
  group = Group.new
  group.category_id = rand_range(1..8)
  group.name = Faker::Company.name
  group.slogan = Faker::Company.catch_phrase
  group.introduction = Faker::Lorem.paragraph(4)
  group.description = Faker::Lorem.paragraph(10)
  group.history = Faker::Lorem.paragraph(10)
  group.organization = Faker::Lorem.paragraph(10)
  group.email = Faker::Internet.free_email
  group.points = rand_range(100..1000)
  group.founded_at = Time.now
  group.logo = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
  group.boss_id = rand_range(1..11)
  group.save
end
