Deface::Override.new(virtual_path: "decidim/messaging/conversations/show", name: "remove-reply-conversation-form", replace: "erb:contains('render \"reply\", form: @form, conversation: conversation')") do
  "
  <% if current_organization.can_user_send_private_message? || conversation.participants.any?(&:admin?) %>
    <%= render 'reply', form: @form, conversation: conversation %>
  <% end %>
"
end