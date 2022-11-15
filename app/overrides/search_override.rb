# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Esclusione dai risultati di ricerca degli utenti e dei relativi commenti in base ai settings

# frozen_string_literal: true

module Decidim
  class Search

    def filtered_query_for(class_name)
      query = SearchableResource.where(
        organization: organization,
        locale: I18n.locale,
        resource_type: class_name
      )

      clean_filters.each_pair do |attribute_name, value|
        query = query.where(attribute_name => value)
      end

      setting = organization.privacy_setting ? organization.privacy_setting : organization.create_privacy_setting
      if class_name == "Decidim::User"
        if setting.user_search
          excluded_ids = Decidim::Privacy::Setting.where(decidim_organization_id: organization, user_search: false).pluck(:decidim_user_id)
          query = query.where.not(resource_id: excluded_ids, resource_type: "Decidim::User") if excluded_ids.present?
        else
          query = query.where(resource_id: [], resource_type: "Decidim::User")
        end

      end

      if class_name == "Decidim::Comments::Comment"
        if setting.user_search
          users_ids = Decidim::Privacy::Setting.where(decidim_organization_id: organization, user_search: false).pluck(:decidim_user_id)
          excluded_ids = Decidim::Comments::Comment.where(decidim_author_id: users_ids).pluck(:id)
          query =  query.where.not(resource_id: excluded_ids, resource_type: "Decidim::Comments::Comment") if excluded_ids.present?
        else
          query =  query.where.not(resource_id: [], resource_type: "Decidim::Comments::Comment")
        end
      end

      query = query.order("datetime DESC")
      query = query.global_search(I18n.transliterate(term)) if term.present?
      query
    end

  end
end
