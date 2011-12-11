module UsersHelper
  def liking?(user)
   current_user.user_relations.find_by_liked_id(user) 
  end
end
