class PinsController < ApplicationController
  before_filter :authorize
  def index
    @pins = Pin.all
  end

  def new
    @pin = Pin.new
    @users = User.all
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.save
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
  def pin_params
    params.require(:pin).permit(:user_id, :lat, :long)
  end
end
