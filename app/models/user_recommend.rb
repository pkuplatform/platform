class UserRecommend < ActiveRecord::Base
  belongs_to :user

  def self.recommend(uid)
    user = User.find(uid)
    hash = Hash.new(0)
    user.users_i_like.each do |u|
      u.users_i_like.each do |v|
        hash[v.id] += 1
      end
    end
    result = hash.sort_by { |k, v| v }.reverse
  end
end
