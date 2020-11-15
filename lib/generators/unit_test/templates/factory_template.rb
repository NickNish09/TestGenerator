FactoryBot.define do
  factory :<%= @klass.downcase %> do<% @factory_args.each do |arg| %>
    <%= arg %><% end %>
  end
end
