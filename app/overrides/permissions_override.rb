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
