module V1
  class BaseController < ::ActionController::API
    include Knock::Authenticable
    # include ::ExceptionsHandler

    before_action :authenticate_user_session, :validate_params

    respond_to :json

    # def render(resource)
    #   super json: resource, **render_options
    # end

    # def prepare_date_range
    #   from, to = get_filter_params(:from, :to)
    #   from = from&.to_datetime || DateTime.now
    #   to = to&.to_datetime
    #   @date_range = DateTimeRange.generate start: from, stop: to
    # end
    #
    # def render_options
    #   { include: params[:include]&.underscore }
    # end

    private

    def validate_params
      current_action = params[:action].to_sym
      return true unless schemas[current_action]

      validation_errors = schemas[current_action].call(params).errors
      render json: validation_errors, status: :bad_request
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
