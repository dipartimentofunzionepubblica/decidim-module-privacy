# frozen_string_literal: true

module Decidim
  module Privacy
    module LastActivityOverride
      def query
        scope = super
        filter_privacy(scope)
      end

      private

      def filter_privacy(query)
        setting = @organization.privacy_setting ? @organization.privacy_setting : @organization.create_privacy_setting
        if setting.user_public_page
          excluded_ids = Decidim::Privacy::Setting.where(decidim_organization_id: @organization, user_public_page: [false, nil]).pluck(:decidim_user_id)
          query = query.where.not(decidim_user_id: excluded_ids) if excluded_ids.present?
        else
          query = query.where(decidim_user_id: [-1]) # All hidden beacause the organization has disabled the public page for all users
        end
        query
      end

    end
  end
end