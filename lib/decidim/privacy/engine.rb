# frozen_string_literal: true

module Decidim
  module Privacy
    # This is the engine that runs on the public interface of privacy.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Privacy

      routes do
        # Add engine routes here
        resources :privacy, only: [:edit, :update]
        root to: "privacy#edit"
      end

      def load_seed
        nil
      end

      initializer "decidim_privacy.add_cells_view_paths" do
        # to override decidim-core I need to insert it first in view_paths
        Cell::ViewModel.view_paths.insert(1, File.expand_path("#{Decidim::Privacy::Engine.root}/app/cells"))
        # Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Privacy::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Privacy::Engine.root}/app/views") # for partials
      end

      initializer "decidim_privacy.mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::Privacy::Engine, at: "/privacy", as: "decidim_privacy"
        end
      end

      initializer "decidim_privacy.menu" do
        Decidim.menu :user_menu do |menu|
          s = current_organization.privacy_setting ? current_organization.privacy_setting : current_organization.create_privacy_setting
          user_setting = current_organization.privacy_settings.find_by(decidim_user_id: current_user)
          setting = user_setting || current_user.privacy_settings.create(decidim_organization_id: current_organization.id)
          menu.item I18n.t("menu.privacy", scope: "decidim.user"),
                    decidim_privacy.edit_privacy_path(id: setting),
                    position: 3.5
        end
      end

      initializer "decidim_privacy.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      overrides = "#{Decidim::Privacy::Engine.root}/app/overrides"
      # Rails.autoloaders.main.ignore(overrides)
      config.to_prepare do
        Rails.autoloaders.main.ignore(overrides)
        Dir.glob("#{overrides}/**/*_override.rb").each do |override|
          load override
        end
      end
    end
  end
end
