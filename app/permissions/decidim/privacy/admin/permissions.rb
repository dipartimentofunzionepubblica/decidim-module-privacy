# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Definizione dei permessi per verificare chi può editare i settings dell'organizzazione

# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin
      class Permissions < Decidim::DefaultPermissions
        def permissions
          return permission_action unless user

          return permission_action unless user&.admin?

          return permission_action if permission_action.scope != :admin

          return permission_action unless permission_action.subject.in? [:admin_setting]

          return permission_action if context[:current_organization].privacy_setting != context[:setting]

          case permission_action.action
          when :update
            permission_action.allow!
          end

          permission_action
        end
      end
    end
  end
end