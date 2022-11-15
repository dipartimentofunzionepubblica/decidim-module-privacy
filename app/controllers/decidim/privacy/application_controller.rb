# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Aggiungo i permessi per privacy nel frontend

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
