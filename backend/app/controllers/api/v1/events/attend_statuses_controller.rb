# frozen_string_literal: true

module Api
  module V1
    module Events
      class AttendStatusesController < ApplicationController
        def index
          attend_statuses = AttendStatus.all
                                        .joins(:schedule_candidate)
                                        .where(schedule_candidate: { event_id: params[:event_id] }, user_id: @user.id)
          results = []
          attend_statuses.each do |as|
            result = {
              id: as.id,
              schedule_candidate_id: as.schedule_candidate_id,
              status: as.status
            }
            results.push(result)
          end
          render json: results
        end
      end
    end
  end
end
