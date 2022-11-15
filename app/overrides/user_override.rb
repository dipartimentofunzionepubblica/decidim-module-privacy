# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Aggiunti metodi che ritornano i valori dei settings

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

    def can_user_send_private_message?
      s, us = setts
      s.user_message && us.user_message
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