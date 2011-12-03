module UsersHelper
  def liking?(liked)
   current_user.user_relations.find_by_liked_id(liked) 
  end
end
