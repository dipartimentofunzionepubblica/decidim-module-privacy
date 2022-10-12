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
