# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Privacy
    describe PrivacyController, type: :controller do
      routes { Decidim::Privacy::Engine.routes }

      let(:current_organization) { create :organization }
      let(:user) { create :user, :confirmed, organization: current_organization }
      let(:other_user) { create(:user, :confirmed, organization: current_organization) }
      let(:current_setting) { current_organization.privacy_settings.find_by(decidim_user_id: user, decidim_organization_id: current_organization) || user.privacy_settings.create(organization: current_organization) }
      # let(:subject) { described_class.new(form, current_setting, user) }

      describe "Permission to edit owner setting" do

        before do
          request.env["decidim.current_organization"] = current_organization
          sign_in user
        end

        describe "#edit" do
          it "can edit own setting" do
            get :edit, params: { id: current_setting.id }
            expect(response).to have_http_status(:ok)
          end

          it "cannot edit setting" do
            sign_in other_user
            get :edit, params: { id: current_setting.id }
            expect(response).to have_http_status(:found)
          end
        end
      end

      describe "#update" do

        before do
          request.env["decidim.current_organization"] = current_organization
          sign_in user
        end

        it "can update own setting" do
          put :update, params: { id: current_setting.id, setting: { user_follow: false } }
          expect(response).to redirect_to("http://test.host/privacy/privacy/#{current_setting.id}/edit")
          expect(response).to have_http_status(:found)
          expect(current_setting.reload.user_follow).to eq(false)
        end

        it "cannot update setting" do
          sign_in other_user
          put :update, params: { id: current_setting.id, setting: { user_follow: false } }
          expect(response).to have_http_status(:found)
        end
      end

    end
  end
end