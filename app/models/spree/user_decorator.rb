require 'cpf_cnpj'
require 'validates_timeliness'

Spree::User.class_eval do

  validates_presence_of :phone, unless: :should_not_validate
  validates :date_of_birth,
            presence: true,
            timeliness: {
              on_or_before: lambda { 18.years.ago.at_end_of_day },
              on_or_after: lambda { 100.years.ago.at_midnight },
              type: :datetime
            }, unless: :should_not_validate
  validates :cpf, presence: true, unless: :should_not_validate
  validates :first_name, :last_name, presence: true, length: {maximum: 100}, unless: :should_not_validate
  validates :phone, :alternative_phone, length: {maximum: 11}, unless: :should_not_validate
  validate :valid_cpf, unless: :should_not_validate

  before_validation :sanitize_fields

  def should_not_validate
    !accepting_invitation? && block_from_invitation?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def cpf_formatted
    CPF::Formatter.format(cpf)
  end

  def phone_area_code
    phone[0..1] if phone
  end

  def phone_number
    phone[2..-1] if phone
  end

  private

  def sanitize(*fields)
    fields.each do |field|
      self[field] = self[field].to_s.gsub(/[^\d]/, '') if self.respond_to?(field)
    end
  end

  def sanitize_fields
    sanitize(:cpf, :phone, :alternative_phone)
  end

  def valid_cpf
    errors.add(:cpf, Spree.t(:invalid)) unless CPF.valid?(cpf)
  end
end
