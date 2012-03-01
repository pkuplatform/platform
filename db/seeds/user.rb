User.delete_all
UserNum = 100
UserNum.times do |i|
  user = User.new
  user.email = i.to_s+Faker::Internet.free_email
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save
end
