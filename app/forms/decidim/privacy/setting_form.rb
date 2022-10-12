# frozen_string_literal: true

module Decidim
  module Privacy
    class SettingForm < Decidim::Form
      attribute :user_avatar, Boolean
      attribute :user_search, Boolean
      attribute :user_follow, Boolean
      attribute :user_index, Boolean
      attribute :user_public_page, Boolean
    end
  end
end
