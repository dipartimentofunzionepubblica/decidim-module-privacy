# frozen_string_literal: true

module Decidim
  module Privacy
    class PrivacyController < Privacy::ApplicationController
      include Decidim::UserProfile

      layout "layouts/decidim/user_profile"

      def edit
        enforce_permission_to :update, :setting, setting: current_setting
        @form = form(SettingForm).from_model(current_setting, setting: current_setting)
      end

      def update
        enforce_permission_to :update, :setting, setting: current_setting
        form = form(SettingForm).from_params(params, setting: current_setting)

        UpdateSetting.call(form, current_setting, current_user) do
          on(:ok) do
            flash[:notice] = I18n.t("privacy.update.success", scope: "decidim.privacy")
            redirect_to decidim_privacy.edit_privacy_path(id: current_setting)
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("privacy.update.error", scope: "decidim.privacy")
            render :edit
          end
        end
      end

      def current_setting
        @current_setting ||= current_organization.privacy_settings.find_by(id: params[:id])
      end

    end
  end
end