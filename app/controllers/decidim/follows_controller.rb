# frozen_string_literal: true

require_dependency Decidim::Core::Engine.root.join('app', 'controllers', 'decidim', 'follows_controller').to_s

module Decidim

  class FollowsController


    def destroy
      @form = form(Decidim::FollowForm).from_params(params)
      @inline = params[:follow][:inline] == "true"
      enforce_permission_to :delete, :follow, follow: @form.follow, resource: resource

      DeleteFollow.call(@form, current_user) do
        on(:ok) do
          render :update_button
        end

        on(:invalid) do
          render json: { error: I18n.t("follows.destroy.error", scope: "decidim") }, status: :unprocessable_entity
        end
      end
    end

    def create
      @form = form(Decidim::FollowForm).from_params(params)
      @inline = params[:follow][:inline] == "true"
      enforce_permission_to :create, :follow, resource: resource

      CreateFollow.call(@form, current_user) do
        on(:ok) do
          render :update_button
        end

        on(:invalid) do
          render json: { error: I18n.t("follows.create.error", scope: "decidim") }, status: :unprocessable_entity
        end
      end
    end

  end
end
