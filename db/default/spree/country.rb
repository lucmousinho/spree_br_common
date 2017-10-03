unless Spree::Country.exists?(iso_name: 'BRAZIL')
  country = Spree::Country.create!(name: 'Brasil', iso3: 'BRA', iso: 'BR', iso_name: 'BRAZIL', numcode: '76', states_required: true)
else
  country = Spree::Country.where(iso_name: 'BRAZIL').first
end

Spree::Config[:default_country_id] = country.id
