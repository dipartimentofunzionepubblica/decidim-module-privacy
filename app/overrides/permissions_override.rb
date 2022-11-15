# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Necessario override per gestire i permissi in base ai settings per "Segui" e "Messaggi privati"

# frozen_string_literal: true

module Decidim
  class Permissions

    private

    def follow_action?
      return unless permission_action.subject == :follow
      organization = context.fetch(:current_organization, nil)
      resource = context.fetch(:resource, nil)
      return disallow! if resource.is_a?(Decidim::User) && !organization.can_user_follow?
      return allow! if permission_action.action == :create


      follow = context.fetch(:follow, nil)
      toggle_allow(follow&.user == user)
    end

    def conversation_action?
      return unless permission_action.subject == :conversation
      return allow! if permission_action.action == :list

      conversation = context.fetch(:conversation)
      interlocutor = context.fetch(:interlocutor, user)
      organization = context.fetch(:current_organization, nil)

      return disallow! if !organization.can_user_send_private_message? && [:create, :update].include?(permission_action.action) && !conversation.participants.any?(&:admin?)
      return disallow! if [:create, :update].include?(permission_action.action) && !conversation&.accept_user?(interlocutor)

      toggle_allow(conversation&.participating?(interlocutor))
    end

  end
end
