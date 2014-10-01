class Admin::UsersController < ApplicationController
 
before_action :authorize
  

  def index
    redirect_to movies_path if @current_user.admin?

    @users = User.all
  end

  # def authorize
  #   unless current_user && current_user.admin
  #     flash[:error] = 'You have to be an admin to access this page.'
  #     redirect_to :root
  #   end
    
  # end


end
