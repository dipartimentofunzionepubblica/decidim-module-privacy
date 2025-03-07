# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# frozen_string_literal: true

module Decidim
  module Privacy
    # This is the engine that runs on the public interface of `Privacy`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Privacy::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        resources :privacy, only: [:edit, :update]
        root to: "privacy#edit"
      end

      def load_seed
        nil
      end

      initializer "decidim_privacy.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::Privacy::AdminEngine, at: "/admin/privacy", as: "decidim_admin_privacy"
        end
      end

      initializer "decidim_privacy.admin_menu" do
        Decidim.menu :admin_settings_menu do |menu|
          setting = current_organization.privacy_setting ? current_organization.privacy_setting : current_organization.create_privacy_setting
          menu.add_item :privacy_settings,
                    I18n.t("menu.privacy", scope: "decidim.admin"),
                    decidim_admin_privacy.edit_privacy_path(id: setting),
                    icon_name: 'lock-2-line',
                    position: 3.5
        end
      end

      initializer "decidim_admin_privacy.add_cells_view_paths" do
        # Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Privacy::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Privacy::Engine.root}/app/views") # for partials
      end
    end
  end
end
