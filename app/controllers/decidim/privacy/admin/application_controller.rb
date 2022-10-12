# frozen_string_literal: true

module Decidim
  module Privacy
    module Admin

      class ApplicationController < Decidim::Admin::ApplicationController

        def permission_class_chain
          [Decidim::Privacy::Admin::Permissions] + super
        end

      end
    end
  end
end
