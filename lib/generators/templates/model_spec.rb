require 'rails_helper'

RSpec.describe <%= @klass %>, type: :model do<% @validations_specs.each do |validation| %>
  <%= validation %>
<% end %><% @associations_specs.each do |association| %>
  <%= association %>
<% end %>
  <%= @subject_spec %>
<% @methods_specs.each do |method| %>
  <%= method %>
<% end %>end
