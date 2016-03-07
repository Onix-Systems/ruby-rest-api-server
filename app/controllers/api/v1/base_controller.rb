class API::V1::BaseController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_api_v1_user!
  protect_from_forgery with: :null_session

  respond_to :json
  rescue_from ActionController::ParameterMissing, :with => :missing_param

  def routing_error
    render json: {errors: [{'title': 'Request-URI not found', 'status': '404'}]}, status: 404
  end

  private

  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def missing_param(exception)
    render json: {error: exception.message}, status: 404
  end
end
