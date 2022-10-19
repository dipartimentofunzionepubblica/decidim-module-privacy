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
    user_index { true }
    user_public_page { true }

    # factory :disabled_follow do
    #   user_follow { false }
    # end
  end

  # Add engine factories here
end
