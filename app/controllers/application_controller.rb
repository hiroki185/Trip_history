class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: :devise_controller?

  def authenticate_user!
    if admin_signed_in?
      authenticate_admin!
    else
      super
    end
  end
end
