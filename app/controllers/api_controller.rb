class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :delegate

  def delegate 
    task = params[:task]
    case task
    when "signup"
      render json: {error: "User already logged in"}, status: 404
    when "login"
      render json: {error: "User already logged in"}, status: 404
    when "logout"
      logout
    when "test"
      test
    when "userAddPin"
      userAddPin
    when "getInstancesOf"
      getInstancesOf
    when "getUserPinsOfType"
      getUserPinsOfType
    when "userDeletePin"
      userDeletePin
    end
  end

  def signup
    user = User.new(first_name: params[:firstName], last_name: params[:lastName], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:passwordConfirmation] )
    if user.save
      session[:user_id] = user.id
      render json: {
        task: params[:task],
        status: "success",
        userId: user.id,
        username: user.username
      }
    else
      render json: {
        task: params[:task],
        status: "failure",
        message: user.errors.messages
      }
    end
  end

  def login
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        task: params[:task],
        status: 'success',
        userId: user.id,
        username: user.username
      }
    else
      render json: {
        task: params[:task],
        status: 'failure',
        message: 'Incorrect password.' 
      }
    end
  end

  def logout
    user = User.find_by_username(params[:user_id])
    if session[:user_id]
      session[:user_id] = nil
      render json: {
        task: params[:task],
        status: 'success',
        userId: params[:user_id]
      }
      else
      render json: {
        task: params[:task],
        status: "failure",
        message: "user not logged in"
      }
    end
  end

  #Create - userId, time, aggressionType, aggressionLat, aggressionLong
  def userAddPin
    pin = Pin.create(lat: params[:aggressionLat], lng: params[:aggressionLong], aggression_type: params[:aggressionType].downcase, user_id: params[:userId]);
    
    render json: {
      time: pin.created_at,
      aggressionType: pin.aggression_type.capitalize,
      coordinate: pin.coordinate
    }
  end

  #Read - aggressionType, withinRadius, withinDays
  def getInstancesOf
    pins = Pin.where(aggression_type: params[:aggressionType].downcase)
    pins = pins.where("created_at > ?", params[:withinDays].to_i.days.ago) if params[:withinDays]
    pins = pins.within(params[:withinRadius], origin: [params[:withinLat].to_f, params[:withinLong].to_f]) if (params[:withinRadius] && params[:withinLat] && params[:withinLong])
    instances = pins.map{|p| {time: p.created_at, coordinate: p.coordinate}}
    render json: {
      aggression: params[:aggressionType],
      instances: instances
    }
  end 

  # aggressionType, userId, withinRadius, withinDays
  def getUserPinsOfType
    user = User.find(params[:userId])
    pins = user.pins.where(aggression_type: params[:aggressionType].downcase)
    pins = pins.where("created_at > ?", params[:withinDays].to_i.days.ago) if params[:withinDays]
    pins = pins.within(params[:withinRadius], origin: [params[:withinLat].to_f, params[:withinLong].to_f]) if (params[:withinRadius] && params[:withinLat] && params[:withinLong])
    instances = pins.map{|p| {time: p.created_at, coordinate: p.coordinate}}
    render json: {
      userId: params[:userId],
      aggression: params[:aggressionType],
      instances: instances
    }
  end


  #Delete - userId, time, aggressionType, aggressionLat, aggressionLong
  def userDeletePin
    if !(params[:userId].blank? or params[:time].blank? or params[:aggressionType].blank? or params[:aggressionLat].blank? or params[:aggressionLong].blank?)
      user = User.find(params[:userId])
      pins = user.pins.where(aggression_type: params[:aggressionType], lat: params[:aggressionLat], lng: params[:aggressionLong])
      deleted_pins = 0
      pins.each do |pin|
        if (pin.created_at - Time.new(params[:time])).abs < 300
            pin.destroy
            deleted_pins = deleted_pins + 1
        end
      end
      render json: {
        message: "Deleted #{deleted_pins} pins"
      }
    else
      render json: {
        errorMessage: "Missing required parameter"
      }
    end
  end
end

