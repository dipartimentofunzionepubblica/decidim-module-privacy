# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Override necessario per gestire la visibilità dei tabs del profilo

require_dependency Decidim::Core::Engine.root.join('app', 'cells', 'decidim', 'profile_cell').to_s

module Decidim
  class ProfileCell
    def user_tabs
      items = [].tap do |keys|
        keys << :activity if profile_holder.can_show_public_page? || current_user == profile_holder || current_user&.admin?
        keys << :badges if current_organization.badges_enabled?
        keys.append(:following)
        keys << :followers if current_organization.can_user_follow?
        keys << :groups if user_groups_enabled?
      end
      items.map { |key| tab_item(key) }
    end
  end
end

