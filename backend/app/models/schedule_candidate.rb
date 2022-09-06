# frozen_string_literal: true

class ScheduleCandidate < ApplicationRecord
  belongs_to :event
  has_many :attend_statuses, dependent: :destroy
end
