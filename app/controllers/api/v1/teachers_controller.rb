module Api
  module V1
    class TeachersController < Api::V1::BaseController

      def show
        respond_with get_resource
      end

      def index
        plural_resource_name = "@#{resource_name.pluralize}"
        resources = resource_class.where(query_params)
                            .page(page_params[:page])
                            .per(page_params[:page_size])

        instance_variable_set(plural_resource_name, resources)
        respond_with instance_variable_get(plural_resource_name)
      end

      private

        def query_params
          # this assumes that an album belongs to an artist and has an :artist_id
          # allowing us to filter by this
          params.permit(:name)
        end
    end
  end
end