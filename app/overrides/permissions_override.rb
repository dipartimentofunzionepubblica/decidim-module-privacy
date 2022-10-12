# frozen_string_literal: true

module Decidim
  class Permissions

    private

    def follow_action?
      return unless permission_action.subject == :follow
      organization = context.fetch(:current_organization, nil)
      resource = context.fetch(:resource, nil)
      return disallow! if resource.is_a?(Decidim::User) && !organization.can_user_follow?
      return allow! if permission_action.action == :create


      follow = context.fetch(:follow, nil)
      toggle_allow(follow&.user == user)
    end

  end
end
