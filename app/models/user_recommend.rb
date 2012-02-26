class UserRecommend < ActiveRecord::Base
  belongs_to :user

  scope :group,    where(:recommendable_type => 'Group')
  scope :activity, where(:recommendable_type => 'Activity')

  def self.recommend(uid)
    user = User.find(uid)
    hash = Hash.new(0)
    user.follows.each do |u|
      u.follows.each do |v|
        hash[v.id] += 1
      end
    end
    result = hash.sort_by { |k, v| v }.reverse
  end
end
