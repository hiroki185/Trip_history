class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

def authenticate_user!
  if admin_signed_in? || user_signed_in?
    # ログイン済みの場合は何もしない
  else
    redirect_to root_path unless devise_controller? || request.path == root_path # デバイスのコントローラーでない場合およびリダイレクト先がトップページでない場合にのみリダイレクトする
  end
end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    # 他のdeviseの設定も追加できます
  end
end