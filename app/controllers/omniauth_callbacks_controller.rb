class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"])
    if !user.nil? && user.persisted?
      flash.notice = "Welcome #{user.email}! You are now signed in."
      sign_in_and_redirect user
    else
      redirect_to new_user_session_path, notice: "You must be a valid user."
    end
  end

end
