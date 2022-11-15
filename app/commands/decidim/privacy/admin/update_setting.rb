# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin
      class UpdateSetting < Rectify::Command
        def initialize(form, setting, user)
          @form = form
          @setting = setting
          @user = user
        end

        # Updates the blog if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            update_setting!
          end

          broadcast(:ok, setting)
        end

        private

        attr_reader :form, :setting

        def update_setting!
          setting.update!(
            user_avatar: form.user_avatar,
            user_search: form.user_search,
            user_follow: form.user_follow,
            user_message: form.user_message,
            user_index: form.user_index,
            user_public_page: form.user_public_page
          )
        end
      end
    end
  end
end
