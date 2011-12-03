User.delete_all
100.times do |i|
  user = User.new
  user.email = i.to_s+Faker::Internet.free_email
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!

  rand_range(10..50).times do |j|
    user_group = UserGroup.new
    user_group.user_id = user.id
    user_group.group_id = rand_range(1..100)
    status = 1 << 2
    privilege = rand_range(1..4)
    like = rand_range(0..1)
    join = rand_range(0..1)
    user_group.status = status + (1 << (7 + privilege)) + (like << 16) + (join << 17)
    user_group.save
  end

  rand_range(10..100).times do |k|
    user_activity = UserActivity.new
    user_activity.user_id = user.id
    user_activity.activity_id = rand_range(1..500)
    status = 1 << 2
    privilege = rand_range(1..4)
    like = rand_range(0..1)
    join = rand_range(0..1)
    user_activity.status = status + (1 << (7 + privilege)) + (like << 16) + (join << 17)
    user_activity.save
  end
end
