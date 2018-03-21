class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      update_avatar(auth)
      sign_in_and_redirect @user
    else
      session['devise.facebook_data'] = auth
      redirect_to new_user_session_path
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def update_avatar(auth)
    if auth.info.image.present?
      auth_image = auth.info.image.gsub('http://', 'https://')
      @user.update_attribute(:remote_avatar_url, auth_image)
    end
  end
end
