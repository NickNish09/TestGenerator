FactoryBot.define do
  factory :<%= @factory_name %> do<% @factory_attrs.each do |attr| %>
    <%= attr %><% end %>
  end
end
