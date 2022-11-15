# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Aggiunti metodi che ritornano i valori dei settings

module Decidim
  class Organization

    has_many :privacy_settings, class_name: "Decidim::Privacy::Setting", foreign_key: :decidim_organization_id, dependent: :destroy
    has_one :privacy_setting, -> { where(decidim_user_id: nil) }, class_name: "Decidim::Privacy::Setting", foreign_key: :decidim_organization_id, dependent: :destroy

    after_create :need_create_privacy_setting

    def can_upload_avatar?
      self.privacy_setting.user_avatar
    end

    def can_user_follow?
      self.privacy_setting.user_follow
    end

    def can_user_send_private_message?
      self.privacy_setting.user_message
    end

    def need_create_privacy_setting
      self.create_privacy_setting
    end

  end
end