class UsersController < ApplicationController
  def index
  end

  def new
    redirect_to 'https://github.com/login/oauth/authorize?client_id=b315b65040180303faa0'
  end

  def create
  end

  def show
  end
end
