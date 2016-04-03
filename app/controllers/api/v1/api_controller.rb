module API
  module V1
    class APIController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_api_v1_user!

      respond_to :json

      rescue_from ActionController::RoutingError, with: :routing_error
      rescue_from ActionController::UnknownFormat, with: :unknown_format
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordNotUnique, with: :unprocessable_entity

      private

      def routing_error
        render json: { error: exception.message }, status: 404
      end

      def unknown_format
        render json: { error: exception.message }, status: 406
      end

      def parameter_missing(exception)
        render json: { error: exception.message }, status: 400
      end

      def unprocessable_entity(exception)
        render json: { error: exception.message }, status: 422
      end

      def record_not_found(exception)
        render json: { error: exception.message }, status: 404
      end
    end
  end
end
