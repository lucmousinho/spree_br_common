class Spree::City < Spree::Base
  has_many :zone_members,
             -> { where(zoneable_type: 'Spree::City') },
             class_name: 'Spree::ZoneMember',
             dependent: :destroy,
             foreign_key: :zoneable_id

  has_many :zones, through: :zone_members, class_name: 'Spree::Zone'

  belongs_to :state
  has_one :country, through: :state

  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:state_id]

  def state_and_city
    state ? "#{state.name}- #{name}" : name
  end
end
