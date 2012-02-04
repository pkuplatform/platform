Blog.delete_all
1000.times do |i|
  blog = Blog.new
  blog.author_id = rand_range(1..99)
  blog.activity_id = rand_range(1..499)
  blog.title = Faker::Name.name
  blog.content = Faker::Lorem.paragraph(10)
  blog.save
end
