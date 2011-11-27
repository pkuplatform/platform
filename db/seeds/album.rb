Album.delete_all
20.times do |i|
  album = Album.new
  album.imageable = Activity.find(rand_range(1..50))
  album.title = Faker::Lorem.sentence(5)
  album.save
  10.times do |j|
    picture = Picture.new
    picture.photo = File.open(File.expand_path("../../pics/#{rand_range(1..52)}.jpg", __FILE__))
    picture.album = album
    picture.user_id = rand_range(1..100)
    picture.save
  end
end
