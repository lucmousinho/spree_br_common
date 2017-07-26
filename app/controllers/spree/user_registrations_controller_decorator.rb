Spree::UserRegistrationsController.class_eval do
  include Spree::BaseHelper
  before_action :parse_date_of_birth, :only => [:create, :update]

  protected

  def parse_date_of_birth
    params[:spree_user][:date_of_birth] = DateTime.strptime(
      params[:spree_user][:date_of_birth], '%Y-%m-%d'
    ) rescue ''
  end
end
