class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :delegate

  def delegate 
    task = params[:task]
    case task
    when "test"
      test
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
end

