# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Model dei setting

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