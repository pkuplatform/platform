Blog.delete_all
50.times do |i|
  blog = Blog.new
  blog.author_id = rand_range(1..11)
  blog.activity_id = rand_range(1..20)
  blog.title = Faker::Name.name
  blog.content = Faker::Lorem.paragraph(10)
  blog.save
end
