Deface::Override.new({
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_city_to_configuration_submenu',
  insert_before: "erb[loud]:contains('Spree.t(:payment_methods)')",
  text: "
    <% if state = Spree::State.find_by_id(Spree::Config[:default_state_id]) || country.states.first %>
      <%= configurations_sidebar_menu_item(Spree.t(:cities), 
      spree.admin_state_cities_path(state)) if can? :manage, Spree::State %>
    <% end %>
  "
})
