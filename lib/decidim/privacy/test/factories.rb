# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :privacy_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :privacy).i18n_name }
    manifest_name :privacy
    participatory_space { create(:participatory_process, :with_steps) }
  end

  factory :organization_setting, class: "Decidim::Privacy::Setting" do
    association(:organization)
    association(:user)
    user_avatar { true }
    user_search { true }
    user_follow { true }
    user_message { true }
    user_index { true }
    user_public_page { true }

    # factory :disabled_follow do
    #   user_follow { false }
    # end
  end

  # Add engine factories here
end
