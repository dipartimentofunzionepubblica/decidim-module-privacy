# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Command per la gestione dei settings

# frozen_string_literal: true

module Decidim
  module Privacy
    class UpdateSetting < Rectify::Command
      def initialize(form, setting, user)
        @form = form
        @setting = setting
        @user = user
      end

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