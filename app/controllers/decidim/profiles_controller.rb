# frozen_string_literal: true

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
