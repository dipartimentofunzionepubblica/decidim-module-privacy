# frozen_string_literal: true

require "spec_helper"

describe Decidim::Privacy::Admin::SettingForm do
  subject { described_class.from_params(attributes) }

  let(:organization) { create(:organization) }

  context "when change values" do
    let(:attributes) { { user_follow: false } }

    it { is_expected.to be_valid }
  end

end