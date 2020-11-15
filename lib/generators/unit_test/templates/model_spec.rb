require 'rails_helper'

RSpec.describe <%= @klass %>, type: :model do
  let(:<%= @klass.downcase %>) { create(:<%= @klass.downcase %>) } <% @validations_specs.each do |validation| %>
  <%= validation %>
<% end %><% @associations_specs.each do |association| %>
  <%= association %>
<% end %><% @methods_specs.each do |method| %>
  <%= method %>
<% end %>end
