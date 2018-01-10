module Spree
  module Api
    class CitiesController < Spree::Api::BaseController
      skip_before_action :authenticate_user

      def index
        @cities = scope.ransack(params[:q]).result.order('name ASC')

        if params[:page] || params[:per_page]
          @cities = @cities.page(params[:page]).per(params[:per_page])
        end

        city = @cities.last
        if stale?(city)
          respond_with(@cities)
        end
      end

      def show
        @city = scope.find(params[:id])
        respond_with(@city)
      end

      private
      def scope
        if params[:country_id]
          return Country.find(params[:country_id]).cities.accessible_by(current_ability, :read)
        elsif params[:state_id]
          return City.accessible_by(current_ability, :read).where(state_id: params[:state_id])
        else
          return City.accessible_by(current_ability, :read)
        end
      end
    end
  end
end
