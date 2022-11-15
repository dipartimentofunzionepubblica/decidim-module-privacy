# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:privacy) do |component|
  component.engine = Decidim::Privacy::Engine
  component.admin_engine = Decidim::Privacy::AdminEngine
  component.permissions_class_name = "Decidim::Privacy::Admin::Permissions"
  component.icon = "decidim/privacy/icon.svg"

  # component.on(:before_destroy) do |instance|
  #   # Code executed before removing the component
  # end

  # These actions permissions can be configured in the admin panel
  component.actions = %w(privacy)

  # component.settings(:global) do |settings|
  #   # Add your global settings
  #   # Available types: :integer, :boolean
  #   # settings.attribute :vote_limit, type: :integer, default: 0
  # end

  # component.settings(:step) do |settings|
  #   # Add your settings per step
  # end

  # component.register_resource(:some_resource) do |resource|
  #   # Register a optional resource that can be references from other resources.
  #   resource.model_class_name = "Decidim::Privacy::SomeResource"
  #   resource.template = "decidim/privacy/some_resources/linked_some_resources"
  # end

  # component.register_stat :some_stat do |context, start_at, end_at|
  #   # Register some stat number to the application
  # end

  # component.seeds do |participatory_space|
  #   # Add some seeds for this component
  # end
end
