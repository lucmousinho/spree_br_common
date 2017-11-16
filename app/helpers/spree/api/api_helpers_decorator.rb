module Spree
  module Api
    module ApiHelpers
      mattr_reader :city_attributes

      @@city_attributes = [:id, :name, :ibge_code, :state_id]
      @@address_attributes.push :district, :number
      @@user_attributes.push :first_name, :last_name, :cpf, :phone, :alternative_phone, :date_of_birth

      class << self
        ATTRIBUTES << :city_attributes
      end
    end
  end
end
