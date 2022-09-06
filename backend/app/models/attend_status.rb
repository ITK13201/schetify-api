# frozen_string_literal: true

class AttendStatus < ApplicationRecord
  belongs_to :user
  belongs_to :schedule_candidate
end
