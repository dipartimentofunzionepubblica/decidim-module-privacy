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