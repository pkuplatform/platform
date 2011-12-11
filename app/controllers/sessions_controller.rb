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
  def create
    resource = warden.authenticate(:scope => resource_name, :recall => "#{controller_path}#new")
    if resource.nil?
      redirect_to new_session_path(:user),:alert=> "sign_in_fail"
    else
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end
end
