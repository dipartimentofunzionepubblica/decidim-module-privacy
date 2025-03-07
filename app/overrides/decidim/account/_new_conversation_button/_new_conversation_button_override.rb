
# Remove new conversation button in conversation list
Deface::Override.new(virtual_path: "decidim/messaging/conversations/_new_conversation_button", name: "remove-button-conversation-list",
                     surround: "button#start-conversation-dialog-button", text: "<% if current_organization.can_user_send_private_message? %><%= render_original %><% end %>")

# Remove hidden modal form in conversation list
Deface::Override.new(virtual_path: "decidim/messaging/conversations/_new_conversation_button", name: "remove-form-conversation-list",
                     surround: "erb:contains('decidim_modal id: \"conversation\", class: \"conversation__modal\" do')", closing_selector: "erb[silent]:contains('end')") do
"
<% if current_organization.can_user_send_private_message? %>
  <%= render_original %>
<% end %>
"
end