# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Privacy
    describe Setting, type: :model do

      let(:current_organization) { create :organization }
      let(:current_organization_setting) { current_organization.privacy_settings.find_by(decidim_user_id: nil, decidim_organization_id: current_organization) }

      describe "Setting" do
        subject { current_organization_setting }

        it { should belong_to(:organization).class_name('Decidim::Organization') }
        it { should belong_to(:user).optional(true).class_name('Decidim::User') }

      end

    end
  end
end