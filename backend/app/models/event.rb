# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :users_events, dependent: :destroy
  has_many :users, through: :users_events
  has_many :notifications, dependent: :destroy
  has_many :schedule_candidates, dependent: :destroy
end
