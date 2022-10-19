# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe ProfilesController, type: :controller do
    routes { Decidim::Core::Engine.routes }

    let(:current_organization) { create :organization }
    let(:current_user) { create(:user, :confirmed, organization: current_organization) }
    let(:other_user) { create(:user, :confirmed, organization: current_organization) }

    describe "Same decidim behaviour with default values of the Privacy Module" do

      before do
        request.env["decidim.current_organization"] = current_organization
      end

      describe "get #followers" do
        it "show the list of followers for the anonymous user" do
          get :followers, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

        it "show the list of followers for the logged user" do
          sign_in other_user
          get :followers, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "Changed decidim behaviour with disabled follow feature of the Privacy Module" do
      before do
        request.env["decidim.current_organization"] = current_organization
        current_organization.privacy_setting.update(user_follow: false)
      end

      describe "get #followers" do
        it "return 404 when admin organization disable follow feature for the anonymous user" do
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error(ActionController::RoutingError)
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error("Privacy Module User Follow Disabled")
        end

        it "return 404 when admin organization disable follow feature for other users" do
          sign_in other_user
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error(ActionController::RoutingError)
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error("Privacy Module User Follow Disabled")
        end

        it "return 404 when admin organization disable follow feature for owner user" do
          sign_in current_user
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error(ActionController::RoutingError)
          expect {
            get :followers, params: { nickname: current_user.nickname }
          }.to raise_error("Privacy Module User Follow Disabled")
        end

      end
    end

  end
end