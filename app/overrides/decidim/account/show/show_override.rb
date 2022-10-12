Deface::Override.new(virtual_path: "decidim/account/show", name: "user-can-upload-image", replace: "div.columns.large-4") do
"
  <% if current_organization.can_upload_avatar? %>
    <div class='columns large-4'>
      <%= f.upload :avatar %>
    </div>
  <% end %>
"
end