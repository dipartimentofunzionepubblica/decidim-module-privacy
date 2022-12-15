# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Override necessario per gestire la visibilità del link di un profilo

module Decidim
  class UserPresenter

    def profile_path
      return false if respond_to?(:can_show_public_page?) && !can_show_public_page?
      return "" if respond_to?(:deleted?) && deleted?

      decidim.profile_path(__getobj__.nickname)
    end

    def profile_url
      return false if respond_to?(:can_show_public_page?) && !can_show_public_page?
      return "" if respond_to?(:deleted?) && deleted?

      decidim.profile_url(__getobj__.nickname, host: __getobj__.organization.host)
    end

  end
end