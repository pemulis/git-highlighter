class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_login(auth['extra']['raw_info']['login']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:oauth_token] = auth['credentials']['token']
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil 
    redirect_to root_url
  end
end
