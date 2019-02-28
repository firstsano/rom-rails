module V1
  class BaseController < ::ActionController::API
    include ::Knock::Authenticable
    include ::Exceptions::ExceptionsHandler

    before_action :authenticate_user_session, :validate_params

    respond_to :json

    private

    def validate_params
      current_action = params[:action].to_sym
      return true unless schemas[current_action]

      unsafe_params = params.to_unsafe_h
      validation_errors = schemas[current_action].call(unsafe_params).errors
      render json: validation_errors, status: :bad_request unless validation_errors.empty?
    end

    def schemas
      {}
    end

    def get_pagination_params
      @page, @per_page = get_filter_params(:page, :per_page)
      @page ||= 1
      @per_page ||= 10
    end

    def get_filter_params(*attributes)
      return Array.new(attributes.count) unless params[:filter]
      params[:filter].values_at(*attributes)
    end
  end
end
