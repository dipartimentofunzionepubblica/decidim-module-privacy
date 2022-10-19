# frozen_string_literal: true

require "spec_helper"

describe Decidim::Privacy::Admin::Permissions do
  subject { described_class.new(admin_user, permission_action, context).permissions.allowed? }

  let(:current_organization) { create :organization }
  let(:admin_user) { create :user, :confirmed, :admin, organization: current_organization }
  let(:user) { create :user, :confirmed, organization: current_organization }
  let(:current_setting) { current_organization.privacy_settings.find_by(decidim_user_id: nil, decidim_organization_id: current_organization) }

  let(:permission_action) { Decidim::PermissionAction.new(action) }
  let(:context) { { setting: current_setting, current_organization: current_organization} }

  context "when permission not set" do
    context "when edit setting with wrong scope" do
      let(:action) { { scope: :setting, action: :update, subject: :admin_setting } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong subject" do
      let(:action) { { scope: :admin, action: :update, subject: :follow } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong action" do
      let(:action) { { scope: :admin, action: :index, subject: :follow } }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with wrong context" do
      let(:action) { { scope: :admin, action: :update, subject: :admin_setting } }
      let(:context) { { setting: current_organization.privacy_setting, current_organization: current_organization} }
      it_behaves_like "permission is not set"
    end

    context "when edit setting with !admin" do
      subject { described_class.new(user, permission_action, context).permissions.allowed? }
      let(:action) { { scope: :admin, action: :update, subject: :admin_setting } }
      it_behaves_like "permission is not set"
    end

    subject { described_class.new(user, permission_action, context).permissions.allowed? }
  end

  context "when permission is allowed" do
    context "when edit setting right" do
      let(:action) { { scope: :admin, action: :update, subject: :admin_setting } }
      it { is_expected.to eq true }
    end

  end
end