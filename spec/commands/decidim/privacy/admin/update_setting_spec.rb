# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Privacy
    module Admin
      describe UpdateSetting do


        let(:current_organization) { create :organization }
        let(:user) { create :user, organization: current_organization }
        let(:current_setting) { current_organization.privacy_settings.find_by(decidim_user_id: nil, decidim_organization_id: current_organization) }
        let(:subject) { described_class.new(form, current_setting, user) }

        let(:form) do
          SettingForm
            .from_model(current_setting)
            .with_context(current_user: user, setting: current_setting)
        end

        context "when user updates the settings" do
          it "broadcasts ok" do
            expect { subject.call }.to broadcast :ok
          end

          it "creates a setting" do
            expect do
              subject.call
            end.to change(::Decidim::Privacy::Setting, :count).by(1) # Organization
          end

          it "updates a setting" do
            current_setting.user_follow = false
            SettingForm.from_model(current_setting).with_context(current_user: user, setting: current_setting)
            subject.call
            r = ::Decidim::Privacy::Setting.find_by(user: nil, organization: current_organization)
            expect(r.user_follow).to eq(current_setting.user_follow)
          end

        end
      end
    end
  end
end