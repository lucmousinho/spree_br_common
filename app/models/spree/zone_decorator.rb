Spree::Zone.class_eval do
  with_options through: :zone_members, source: :zoneable do
      has_many :cities, source_type: 'Spree::City'
  end

  def include?(address)
    return false unless address

    members.any? do |zone_member|
      case zone_member.zoneable_type
      when 'Spree::Country'
        zone_member.zoneable_id == address.country_id
      when 'Spree::State'
        zone_member.zoneable_id == address.state_id
      when 'Spree::City'
        zone_member.zoneable_id == address.city_id
      else
        false
      end
    end
  end

  def city?
    kind == 'city'
  end

   def city_ids
     if city?
       members.pluck(:zoneable_id)
     else
       []
     end
   end

   def city_ids=(ids)
     set_zone_members(ids, 'Spree::City')
   end

  def country_list
    @countries ||= case kind
                   when 'country' then
                     zoneables
                   when 'state' then
                     zoneables.collect(&:country)
                   when 'city' then
                     zoneables.country_list
                   else
                     []
                   end.flatten.compact.uniq
  end

  def contains?(target)
    return false if state? && !target.state?
    return false if zone_members.empty? || target.zone_members.empty?

    if kind == target.kind
      if city?
        return false if (target.cities.pluck(:id) - cities.pluck(:id)).present?
      elsif state?
        return false if (target.states.pluck(:id) - states.pluck(:id)).present?
      elsif country?
        return false if (target.countries.pluck(:id) - countries.pluck(:id)).present?
      end
    else
      return false if (target.states.pluck(:country_id) - countries.pluck(:id)).present?
    end
    true
  end
end
