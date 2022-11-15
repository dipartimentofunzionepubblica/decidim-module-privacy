Deface::Override.new(virtual_path: "decidim/messaging/conversations/index", name: "remove-new-conversation-button", replace: "erb:contains('render partial: \"new_conversation_button\"')") do
  "
  <% if current_organization.can_user_send_private_message? %>
    <%= render partial: 'new_conversation_button' %>
  <% end %>
"
end