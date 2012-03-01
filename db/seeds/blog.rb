Blog.delete_all
500.times do |i|
  blog = Blog.new
  blog.author_id = rand_range(1..99)
  blog.activity_id = rand_range(1..199)
  blog.title = Faker::Name.name
  blog.content = Faker::Lorem.paragraph(10)
  blog.save
end
