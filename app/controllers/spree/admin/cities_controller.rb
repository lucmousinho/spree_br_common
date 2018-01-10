class Spree::Admin::CitiesController < Spree::Admin::ResourceController
  belongs_to 'spree/state'

  before_action :load_data

  def index
    respond_with(@collection) do |format|
      format.html
      format.js  { render partial: 'cities_list' }
    end
  end

  protected

  def location_after_save
    admin_state_cities_url(@state)
  end

  def collection
    super.order(:name)
  end

  def load_data
    @countries = Spree::Country.order(:name)
    @country = @state.country
    @states = @country.states
  end
end
