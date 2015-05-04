class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :delegate

  def delegate 
    task = params[:task]
    case task
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

  #Create 
  def userAddPin
    #params: userId, time, aggressionType, aggressionLat, aggressionLong
    render json: {
      userId: 1,
      time: "2015-03-28T23:14:04Z",
      aggressionType: "Sexism",
      coordinate: [37.3492, -121.9381]
    }
  end

  #Read 
  def getInstancesOf
    #params: aggressionType, withinRadius, withinDays
    render json: {
      aggression: "Sexism",
      instances: [ 
        {
          userId: 1,
          time: "2015-04-1T12:04:00Z",
          coordinate: [37.3492, -121.9876]
        },{
          userId: 2,
          time: "2015-04-2T12:04:00Z",
          coordinate: [37.3492, -121.8765]
        },{
          userId: 3,
          time: "2015-04-3T12:04:00Z",
          coordinate: [37.3492, -121.7654]
        }  
      ]
    }
  end 
  def getUserPinsOfType
    #params: aggressionType, userId, withinRadius, withinDays
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

  #Delete? 
  def userDeletePin
    #params: userId, time, aggressionType, aggressionLat, aggressionLong)
    render json: {
      userId: 1,
      time: "2015-03-28T23:14:04Z",
      aggression: "Sexism",
      coordinate: [37.3492, -121.9381]
    }
  end
end

