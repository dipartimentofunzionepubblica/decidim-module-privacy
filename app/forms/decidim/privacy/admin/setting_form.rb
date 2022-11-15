# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Form che gestische i setting in amministrazione

# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin
      class SettingForm < Decidim::Form
        attribute :user_avatar, Boolean
        attribute :user_search, Boolean
        attribute :user_follow, Boolean
        attribute :user_message, Boolean
        attribute :user_index, Boolean
        attribute :user_public_page, Boolean
      end
    end
  end
end
