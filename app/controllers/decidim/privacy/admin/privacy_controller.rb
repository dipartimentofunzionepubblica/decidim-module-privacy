# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Controller per l'update dei settings in amministrazione

# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin
      class PrivacyController < Privacy::Admin::ApplicationController
        layout "decidim/admin/settings"

        def edit
          enforce_permission_to :update, :admin_setting, setting: current_setting
          @form = form(SettingForm).from_model(current_setting, setting: current_setting)
        end

        def update
          enforce_permission_to :update, :admin_setting, setting: current_setting
          form = form(SettingForm).from_params(params, setting: current_setting)

          UpdateSetting.call(form, current_setting, current_user) do
            on(:ok) do
              flash[:notice] = I18n.t("privacy.update.success", scope: "decidim.privacy.admin")
              redirect_to decidim_admin_privacy.edit_privacy_path(id: current_setting)
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("privacy.update.error", scope: "decidim.privacy.admin")
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
end