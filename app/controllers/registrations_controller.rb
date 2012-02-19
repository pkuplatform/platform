class RegistrationsController < Devise::RegistrationsController
  protected
  layout 'registration'

  def after_sign_up_path_for(resource)
    home_path
  end
end
