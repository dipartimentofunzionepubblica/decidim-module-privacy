# frozen_string_literal: true

require "spec_helper"

describe Decidim::Permissions do
  subject { described_class.new(user, permission_action, context).permissions.allowed? }

  let(:current_organization) { create :organization }
  let(:user) { create :user, organization: current_organization }
  let(:other_user) { create :user, organization: current_organization }
  let(:current_setting) { current_organization.privacy_settings.find_by(decidim_user_id: nil, decidim_organization_id: current_organization) }
  let(:proposal) { create(:proposal) }

  let(:permission_action) { Decidim::PermissionAction.new(action) }
  let(:context) { { setting: current_setting, current_organization: current_organization} }

  context "when permission not set" do
    context "when follow with wrong scope" do
      let(:action) { { scope: :follow_wrong, action: :update, subject: :setting } }
      it_behaves_like "permission is not set"
    end

    context "when follow with wrong subject" do
      let(:action) { { scope: :public, action: :update, subject: :follow_wrong } }
      it_behaves_like "permission is not set"
    end

    context "when follow with wrong action" do
      let(:action) { { scope: :public, action: :follow_wrong, subject: :follow } }
      it_behaves_like "permission is not set"
    end

  end

  context "when permission is allowed with default privacy setting" do
    context "when create" do
      let(:action) { { scope: :public, action: :create, subject: :follow } }

      context "when follow create user follow" do
        let(:context) { { resource: other_user, current_organization: current_organization} }
        it { is_expected.to eq true }
      end

      context "when follow create proposal follow" do
        let(:context) { { resource: proposal, current_organization: current_organization} }
        it { is_expected.to eq true }
      end
    end

    context "when destroy" do
      let(:action) { { scope: :public, action: :delete, subject: :follow } }

      context "user follow" do
        let(:follow) { create(:follow, user: user, followable: other_user) }
        let(:context) { { resource: other_user, setting: current_setting, current_organization: current_organization, follow: follow } }
        it { is_expected.to eq true }
      end

      context "proposal follow" do
        let(:follow) { create(:follow, user: user, followable: proposal) }
        let(:context) { { resource: proposal, setting: current_setting, current_organization: current_organization, follow: follow } }
        it { is_expected.to eq true }
      end
    end
  end

  context "when permission change after privacy setting update" do
    before do
      current_setting.update(user_follow: false)
      current_organization.privacy_setting.reload
    end

    context "when create" do
      let(:action) { { scope: :public, action: :create, subject: :follow } }

      context "when follow create user follow" do
        let(:context) { { resource: other_user, current_organization: current_organization} }
        it { is_expected.to eq false }
      end

      context "when follow create proposal follow" do
        let(:context) { { resource: proposal, current_organization: current_organization} }
        it { is_expected.to eq true }
      end
    end

    context "when destroy" do
      let(:action) { { scope: :public, action: :delete, subject: :follow } }

      context "user follow" do
        let(:follow) { create(:follow, user: user, followable: other_user) }
        let(:context) { { resource: other_user, setting: current_setting, current_organization: current_organization, follow: follow } }
        it { is_expected.to eq false }
      end

      context "proposal follow" do
        let(:follow) { create(:follow, user: user, followable: proposal) }
        let(:context) { { resource: proposal, setting: current_setting, current_organization: current_organization, follow: follow } }
        it { is_expected.to eq true }
      end
    end
  end

end