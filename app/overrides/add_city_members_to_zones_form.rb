Deface::Override.new({
  virtual_path: 'spree/admin/zones/_form',
  name: 'add_city_members_to_zones_form',
  insert_before: "erb[loud]:contains('state_members')",
  text: "
    <%= render partial: 'city_members', locals: { zone_form: zone_form }%>
  "
})
