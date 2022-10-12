module Decidim
  class User

    # has_one :privacy_setting, -> (o) { where(decidim_organization_id: o) }, class_name: "Decidim::Privacy::Setting", foreign_key: :decidim_user_id, dependent: :destroy

    has_many :privacy_settings, class_name: 'Decidim::Privacy::Setting', foreign_key: :decidim_user_id, dependent: :destroy do
      def for_organization(organization)
        find_by(decidim_organization_id: organization)
      end
    end

    def can_user_follow?
      s, us = setts
      s.user_follow && us.user_follow
    end

    def can_user_index?
      s, us = setts
      s.user_index && us.user_index
    end

    def can_show_public_page?
      s, us = setts
      s.user_public_page && us.user_public_page
    end

    private

    def setts
      us = self.privacy_settings.for_organization(self.organization)
      [ self.organization.privacy_setting, us || self.privacy_settings.create(decidim_organization_id: self.organization.id) ]
    end

  end
end