User.delete_all
100.times do |i|
  user = User.new
  user.email = Faker::Internet.free_email
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!

  Random.rand(1..10).times do |j|
    user_group = UserGroup.new
    user_group.user = user
    user_group.group_id = Random.rand(1..100)
    user_group.status = Random.rand(1..3)
    user_group.save!
  end

  Random.rand(10..100).times do |k|
    user_activity = UserActivity.new
    user_activity.user = user
    user_activity.activity_id = Random.rand(1..500)
    user_activity.status = Random.rand(1..3)
    user_activity.save!
  end
end
