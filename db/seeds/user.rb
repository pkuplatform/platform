User.delete_all
UserNum = 10
UserNum.times do |i|
  user = User.new
  user.email = i.to_s+Faker::Internet.free_email
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save
  p = user.build_profile
  p.name = "User" + i.to_s
  p.realname = "RealUser" + i.to_s
  p.student_id = "SID" + i.to_s
  p.save
end
