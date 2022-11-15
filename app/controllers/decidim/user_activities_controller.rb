# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Necessario override per disabilitare la pagina "Activity"

# frozen_string_literal: true

require_dependency Decidim::Core::Engine.root.join('app', 'controllers', 'decidim', 'user_activities_controller').to_s

module Decidim
  # The controller to show all the last activities in a Decidim Organization.
  class UserActivitiesController

    def index
      raise ActionController::RoutingError, "Blocked User" if user&.blocked? && !current_user&.admin?
      raise ActionController::RoutingError, "Privacy Module Private page" unless user.can_show_public_page? || user == current_user || current_user&.admin?
    end

  end
end
