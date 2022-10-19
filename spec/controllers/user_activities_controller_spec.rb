# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe UserActivitiesController, type: :controller do
    routes { Decidim::Core::Engine.routes }

    let(:current_organization) { create :organization }
    let(:current_user) { create(:user, :confirmed, organization: current_organization) }
    let(:other_user) { create(:user, :confirmed, organization: current_organization) }
    let(:admin_user) { create(:user, :confirmed, :admin, organization: current_organization) }

    # raise ActionController::RoutingError, "Blocked User" if user&.blocked? && !current_user&.admin?
    # raise ActionController::RoutingError, "Privacy Module Private page" unless user.can_show_public_page? || user == current_user || current_user&.admin?
    #
    describe "Same decidim behaviour with default values of the Privacy Module" do
      before do
        request.env["decidim.current_organization"] = current_organization
      end

      describe "get #index" do
        it "show the list of activities for the logged user" do
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

        it "show the list of activities for the logged user" do
          sign_in other_user
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

        it "show the list of activities for the own user" do
          sign_in current_user
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

        it "show the list of activities for the admin user" do
          sign_in admin_user
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe "Changed decidim behaviour with disabled public page feature of the Privacy Module" do
      before do
        request.env["decidim.current_organization"] = current_organization
        current_organization.privacy_setting.update(user_public_page: false)
      end

      describe "get #index" do
        it "return 404 when admin organization disable follow feature for the anonymous user" do
          expect {
            get :index, params: { nickname: current_user.nickname }
          }.to raise_error(ActionController::RoutingError)
          expect {
            get :index, params: { nickname: current_user.nickname }
          }.to raise_error("Privacy Module Private page")
        end

        it "return 404 when admin organization disable follow feature for other users" do
          sign_in other_user
          expect {
            get :index, params: { nickname: current_user.nickname }
          }.to raise_error(ActionController::RoutingError)
          expect {
            get :index, params: { nickname: current_user.nickname }
          }.to raise_error("Privacy Module Private page")
        end

        it "show the list of activities for the admin user" do
          sign_in current_user
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

        it "show the list of activities for the own user" do
          sign_in admin_user
          get :index, params: { nickname: current_user.nickname }
          expect(response).to have_http_status(:ok)
        end

      end
    end

  end
end