User.delete_all
100.times do |i|
  user = User.new
  user.email = Faker::Internet.free_email
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!

  rand_range(10..50).times do |j|
    user_group = UserGroup.new
    user_group.user_id = user.id
    user_group.group_id = rand_range(1..100)
    user_group.status = rand_range(0..15)
    user_group.save
  end

  rand_range(10..100).times do |k|
    user_activity = UserActivity.new
    user_activity.user_id = user.id
    user_activity.activity_id = rand_range(1..500)
    user_activity.status = rand_range(0..31)
    user_activity.save
  end
end
