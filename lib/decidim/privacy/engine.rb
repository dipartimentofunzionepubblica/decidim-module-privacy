# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Privacy
    # This is the engine that runs on the public interface of privacy.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Privacy

      routes do
        # Add engine routes here
        # resources :privacy
        # root to: "privacy#index"
      end

      initializer "decidim_privacy.assets" do |app|
        app.config.assets.precompile += %w[decidim_privacy_manifest.js decidim_privacy_manifest.css]
      end
    end
  end
end
