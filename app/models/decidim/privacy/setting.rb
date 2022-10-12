# frozen_string_literal: true

module Decidim
  module Privacy
    class Setting < Decidim::ApplicationRecord
      self.table_name = "decidim_privacy_settings"

      include Decidim::Resourceable

      belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"
      belongs_to :user, foreign_key: :decidim_user_id, class_name: "Decidim::User", optional: true

    end
  end
end