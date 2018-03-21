class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to main_app.root_path, notice: exeption.message
  end

  def after_sign_in_path_for(user)
    user.is_admin? ? admin_index_path : root_path
  end

  private

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
end
