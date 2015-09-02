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

  def test
    render json: {
      paramOne: "One",
      paramTwo: "Two",
      array: ["one", "two", "three"],
      hash: {
          keyOne: "valOne",
          keyTwo: "valTwo"
        }
      }
  end

  #Create - userId, time, aggressionType, aggressionLat, aggressionLong
  def userAddPin
    pin = Pin.create(latitude: params[:coordinate][0], longitude: params[:coordinate][1], aggression_type: params[:aggressionType].downcase);
    
    render json: {
      time: pin.created_at,
      aggressionType: pin.aggression_type.capitalize,
      coordinate: pin.coordinate
    }
  end

  #Read - aggressionType, withinRadius, withinDays
  def getInstancesOf
    pins = Pin.where(aggression_type: params[:aggressionType].downcase)
    instances = pins.map{|p| {time: p.created_at, coordinate: p.coordinate}}
    render json: {
      aggression: params[:aggressionType],
      instances: instances
    }
  end 

  # aggressionType, userId, withinRadius, withinDays
  def getUserPinsOfType
    render json: {
      userId: 1,
      aggression: "Racism",
      instances: [ 
        {
          userId: 1,
          time: "2015-04-1T12:04:00Z",
          coordinate: [37.3492, -121.9876]
        },{
          time: "2015-04-2T12:04:00Z",
          coordinate: [37.3492, -121.8765]
        },{
          time: "2015-04-3T12:04:00Z",
          coordinate: [37.3492, -121.7654]
        }  
      ]
    }
  end

  #Update?

  #Delete - userId, time, aggressionType, aggressionLat, aggressionLong
  def userDeletePin
    if !(params[:userId].blank? or params[:time].blank? or params[:aggressionType].blank? or params[:aggressionLat].blank? or params[:aggressionLong].blank?)
      render json: {
        userId: 1,
        time: "2015-03-28T23:14:04Z",
        aggression: "Sexism",
        coordinate: [37.3492, -121.9381]
      }
    else
      render json: {
        errorMessage: "Missing required parameter"
      }
    end
  end
end

