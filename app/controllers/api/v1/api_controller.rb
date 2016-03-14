module API
  module V1
    class APIController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_api_v1_user!

      rescue_from ActionController::ParameterMissing, with: :missing_parameter

      def not_found
        render json: { errors: [title: 'Request-URI not found', status: '404'] }, status: 404
      end

      private

      def missing_parameter(exception)
        render json: { error: exception.message }, status: 404
      end
    end
  end
end
