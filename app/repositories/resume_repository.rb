# frozen_string_literal: true

module ResumeRepository
  extend ActiveSupport::Concern

  included do
    scope :web, -> { order(id: :desc).published }
    scope :web_admin, -> { order(id: :desc) }
  end
end
