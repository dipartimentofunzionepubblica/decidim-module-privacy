# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Abilitazione/disabilitazione dell'indicizzazione dei motori di ricerca in base ai settings

Deface::Override.new(virtual_path: "layouts/decidim/_head", name: "insert-index-options", insert_after: "meta[name='viewport']") do
  "
  <% if (defined?(user) && user && (current_page?(decidim.profile_activity_url(nickname: user.nickname)) || current_page?(decidim.profile_timeline_url(nickname: user.nickname))) && user.respond_to?(:can_user_index?) && !user.can_user_index?) ||
      (defined?(profile_holder) && profile_holder &&
        (current_page?(decidim.profile_following_url(nickname: profile_holder.nickname)) ||
          current_page?(decidim.profile_followers_url(nickname: profile_holder.nickname)) ||
          current_page?(decidim.profile_badges_url(nickname: profile_holder.nickname)) ||
          current_page?(decidim.profile_groups_url(nickname: profile_holder.nickname)) ||
          current_page?(decidim.profile_members_url(nickname: profile_holder.nickname))) && profile_holder.respond_to?(:can_user_index?) && !profile_holder.can_user_index?) %>
        <meta name='robots' content='noindex'>
  <% end %>
"

end

