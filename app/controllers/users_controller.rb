class UsersController < ApplicationController
  def index
    @users = User.all
    #render json: @users, status: 200
    respond_to do |f|
      f.html 
      f.json { render json: @users, status: 200}
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
  end

end
