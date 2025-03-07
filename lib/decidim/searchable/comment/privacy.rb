module Decidim
  module Searchable
    module Comment
      class Privacy

        def self.call(query, organization)
          setting = organization.privacy_setting ? organization.privacy_setting : organization.create_privacy_setting
          if setting.user_search
            users_ids = Decidim::Privacy::Setting.where(decidim_organization_id: organization, user_search: [false, nil]).pluck(:decidim_user_id)
            excluded_ids = Decidim::Comments::Comment.where(decidim_author_id: users_ids).pluck(:id)
            query = query.where.not(resource_id: excluded_ids).where(resource_type: "Decidim::Comments::Comment") if excluded_ids.present?
          else
            query = query.where(resource_id: [], resource_type: "Decidim::Comments::Comment")
          end
          query
        end

      end

    end
  end
end