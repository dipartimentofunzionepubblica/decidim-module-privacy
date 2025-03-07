# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Override necessario per gestire la visibilità dei tabs del profilo

require_dependency Decidim::Core::Engine.root.join('app', 'cells', 'decidim', 'profile_actions_cell').to_s

module Decidim
  class ProfileActionsCell
    # def actions_keys
    #   @actions_keys ||= [].tap do |keys|
    #     keys << :edit_profile if own_profile?
    #     keys << :create_user_group if own_profile? && user_groups_enabled?
    #     keys << message_key if can_contact_user?
    #     keys << :join_user_group if can_join_user_group?
    #     keys << :leave_user_group if can_leave_group?
    #   end
    # end

    def can_contact_user?
      !current_user || ((current_user && current_user != model && presented_profile.can_be_contacted?) && (current_organization.can_user_send_private_message? || (current_user && current_user.admin?) ))
    end
  end
end

