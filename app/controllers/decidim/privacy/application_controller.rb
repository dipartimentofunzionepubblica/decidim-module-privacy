# frozen_string_literal: true

module Decidim
  module Privacy

    class ApplicationController < ::Decidim::ApplicationController

      def permission_class_chain
        [Decidim::Privacy::Permissions] + super
      end

    end
  end
end
