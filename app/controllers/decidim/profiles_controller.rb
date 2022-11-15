# frozen_string_literal: true

# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Necessario override per disabilitare l'action dei followers in base ai settings

require_dependency Decidim::Core::Engine.root.join('app', 'controllers', 'decidim', 'profiles_controller').to_s

module Decidim
  # The controller to handle the user's public profile page.
  class ProfilesController

    def followers
      raise ActionController::RoutingError, "Privacy Module User Follow Disabled" if profile_holder.is_a?(Decidim::User) && !current_organization.can_user_follow?
      @content_cell = "decidim/followers"
      @title_key = "followers"
      render :show
    end

  end

end
