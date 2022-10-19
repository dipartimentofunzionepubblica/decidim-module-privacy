# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Organization, type: :model do

    let(:current_organization) { create :organization }

    describe "Organization" do
      subject { current_organization }

      it { should have_many(:privacy_settings).class_name('Decidim::Privacy::Setting').dependent(:destroy) }
      it { should have_one(:privacy_setting).conditions(decidim_user_id: nil).class_name('Decidim::Privacy::Setting').dependent(:destroy) }

      describe "method with default values" do
        it "should do something" do
          expect(current_organization.can_upload_avatar?).to eq(true)
          expect(current_organization.can_user_follow?).to eq(true)
          expect(current_organization.privacy_settings).not_to be_empty
        end
      end

      describe "method with changed values" do
        before do
          current_organization.privacy_setting.update(user_avatar: false, user_follow: false)
        end

        it "should do something" do
          expect(current_organization.can_upload_avatar?).to eq(false)
          expect(current_organization.can_user_follow?).to eq(false)
          expect(current_organization.privacy_settings).not_to be_empty
        end
      end

    end
  end
end