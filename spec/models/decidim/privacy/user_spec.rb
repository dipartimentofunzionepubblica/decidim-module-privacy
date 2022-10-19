# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe User, type: :model do

    let(:current_organization) { create :organization }
    let(:current_user) { create(:user, :confirmed, organization: current_organization) }

    describe "Organization" do
      subject { current_user }

      it { should have_many(:privacy_settings).class_name('Decidim::Privacy::Setting').dependent(:destroy) }

      describe "method with default values" do
        it "should do something" do
          expect(current_user.privacy_settings).to be_empty
          expect(current_user.can_user_follow?).to eq(true)
          expect(current_user.can_user_index?).to eq(true)
          expect(current_user.can_show_public_page?).to eq(true)
          expect(current_user.privacy_settings).not_to be_empty
        end
      end

      describe "method with changed values" do
        before do
          current_organization.privacy_setting.update(user_public_page: false, user_follow: false, user_index: false)
        end

        it "should do something" do
          expect(current_user.privacy_settings).to be_empty
          expect(current_user.can_user_follow?).to eq(false)
          expect(current_user.can_user_index?).to eq(false)
          expect(current_user.can_show_public_page?).to eq(false)
          expect(current_user.privacy_settings).not_to be_empty
        end
      end

    end
  end
end