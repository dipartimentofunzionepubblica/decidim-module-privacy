# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin
      class Permissions < Decidim::DefaultPermissions
        def permissions
          return permission_action unless user

          return permission_action if permission_action.scope != :admin

          return permission_action unless permission_action.subject.in? [:admin_setting]

          return permission_action if context[:current_organization].privacy_setting != context[:setting]

          case permission_action.action
          when :index, :show, :create, :update, :destroy
            permission_action.allow!
          end

          permission_action
        end
      end
    end
  end
end