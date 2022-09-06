# frozen_string_literal: true

class User < ApplicationRecord
  include UuidGenerator
  has_many :users_events, dependent: :destroy
  has_many :events, through: :users_events
end
