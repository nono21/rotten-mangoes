class Admin::UsersController < ApplicationController
 
before_action :authorize

  def index
    @users = User.all.page(params[:page]).per(2)
  end


end
