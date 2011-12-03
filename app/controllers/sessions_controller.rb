class SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    if session[:post_auth_path]
      url = session[:post_auth_path]
      session[:post_auth_path] = nil
    else
      url = resource
    end
    url
  end
end
