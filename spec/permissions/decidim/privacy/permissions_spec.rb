# frozen_string_literal: true

require "spec_helper"

describe Decidim::Privacy::Permissions do
  subject { described_class.new(user, permission_action, context).permissions.allowed? }

  let(:current_organization) { create :organization }
  let(:user) { create :user, organization: current_organization }
  let(:current_setting) { current_organization.privacy_settings.find_by(decidim_user_id: user, decidim_organization_id: current_organization) || user.privacy_settings.create(organization: current_organization) }

  let(:permission_action) { Decidim::PermissionAction.new(action) }
  let(:context) { { setting: current_setting, current_organization: current_organization} }

  context "when permission not set" do
    context "when edit setting with wrong scope" do
      let(:action) { { scope: :admin, action: :update, subject: :setting } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong subject" do
      let(:action) { { scope: :public, action: :update, subject: :follow } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong action" do
      let(:action) { { scope: :public, action: :index, subject: :follow } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong context" do
      let(:action) { { scope: :public, action: :update, subject: :setting } }
      let(:context) { { setting: current_organization.privacy_setting, current_organization: current_organization} }
      it_behaves_like "permission is not set"
    end
  end

  context "when permission is allowed" do
    context "when edit setting right" do
      let(:action) { { scope: :public, action: :update, subject: :setting } }
      it { is_expected.to eq true }
    end

  end
end