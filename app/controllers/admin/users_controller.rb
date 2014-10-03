class Admin::UsersController < ApplicationController
 
before_action :authorize

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      
      redirect_to admin_users_path, notice: "The user #{@user.firstname} was created with success!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user)
    else
      render :edit
    end 
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_notify(@user).deliver
    redirect_to admin_users_path
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :admin)
    
  end
end

