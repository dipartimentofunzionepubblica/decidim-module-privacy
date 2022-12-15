# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Override necessario per gestire la visibilità del link di un profilo

require_dependency Decidim::Core::Engine.root.join('app', 'cells', 'decidim', 'author_cell').to_s

module Decidim
  class AuthorCell
    def profile_path?
      if (model.respond_to?(:can_show_public_page?) && !model.can_show_public_page?) ||
        (model.is_a?(Decidim::OfficialAuthorPresenter) && !current_organization.can_user_show_public_page?)
        return false
      end
      return false if options[:skip_profile_link] == true

      profile_path.present?
    end
  end
end

