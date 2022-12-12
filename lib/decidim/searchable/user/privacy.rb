module Decidim
  module Searchable
    module User
      class Privacy

        def self.call(query, organization)
          setting = organization.privacy_setting ? organization.privacy_setting : organization.create_privacy_setting
          if setting.user_search
            excluded_ids = Decidim::Privacy::Setting.where(decidim_organization_id: organization, user_search: false).pluck(:decidim_user_id)
            query = query.where.not(resource_id: excluded_ids).where(resource_type: "Decidim::User") if excluded_ids.present?
          else
            query = query.where(resource_id: [], resource_type: "Decidim::User")
          end
          query
        end

      end

    end
  end
end