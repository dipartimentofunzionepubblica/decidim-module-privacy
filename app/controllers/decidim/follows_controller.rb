# Copyright (C) 2022 Formez PA
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>

# Necessario override per passare ai permessi la risorsa corrente (da seguire)

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
