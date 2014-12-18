class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_or_update_for_google_oauth2(request.env['omniauth.auth'], current_user)

    if @user && @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'

      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Google'

      redirect_to root_url
    end
  end
end
