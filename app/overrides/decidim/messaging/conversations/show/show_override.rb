# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Abilitazione/disabilitazione della form per rispondere ad una vecchia conversazione in base ai settings

Deface::Override.new(virtual_path: "decidim/messaging/conversations/show", name: "remove-reply-conversation-form", replace: "erb:contains('render \"reply\", form: @form, conversation:')") do
  "
  <% if current_organization.can_user_send_private_message? || conversation.participants.any?(&:admin?) %>
    <%= render 'reply', form: @form, conversation: conversation %>
  <% end %>
"
end