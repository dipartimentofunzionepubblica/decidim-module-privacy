# frozen_string_literal: true

module Decidim
  module Privacy
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
