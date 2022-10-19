# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe FollowsController, type: :controller do
    routes { Decidim::Core::Engine.routes }

    let(:current_organization) { create :organization }
    let(:current_user) { create(:user, :confirmed, organization: current_organization) }
    let(:other_user) { create(:user, :confirmed, organization: current_organization) }
    let(:proposal) { create(:proposal) }

    describe "Same decidim behaviour with default values of the Privacy Module" do

      before do
        request.env["decidim.current_organization"] = current_organization
        sign_in current_user
      end

      describe "#follow" do
        it "create a new follow for User resource" do
          post :create, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: other_user.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:ok)
        end

        it "create a new follow for Proposal resource" do
          post :create, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: proposal.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:ok)
        end

        it "delete follow" do
          create(:follow, user: current_user, followable: other_user)
          delete :destroy, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: other_user.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "Changed decidim behaviour with disabled follow feature of the Privacy Module" do

      before do
        request.env["decidim.current_organization"] = current_organization
        current_organization.privacy_setting.update(user_follow: false)
        sign_in current_user
      end

      describe "#follow" do
        it "cannot create a new follow for User resource" do
          post :create, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: other_user.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:found)
        end

        it "can create a new follow for Proposal resource" do
          post :create, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: proposal.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:ok)
        end

        it "cannot delete follow" do
          create(:follow, user: current_user, followable: other_user)
          delete :destroy, params: { format: :js, nickname: current_user.nickname, follow: { inline: true, followable_gid: other_user.to_signed_global_id.to_s } }
          expect(response).to have_http_status(:found)
        end

      end
    end

  end
end