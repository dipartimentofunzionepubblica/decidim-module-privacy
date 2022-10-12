# frozen_string_literal: true

module Decidim
  module Privacy
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action unless user

        return permission_action if permission_action.scope != :public

        return permission_action unless permission_action.subject.in? [:setting]

        return permission_action if user.privacy_settings.for_organization(context[:current_organization]) != context[:setting]

        case permission_action.action
        when :update
          permission_action.allow!
        end

        permission_action
      end
    end
  end
end