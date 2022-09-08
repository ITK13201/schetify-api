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

        def update
          data = params['_json']
          ApplicationRecord.transaction do
            existing_attend_statuses = AttendStatus
                                       .all
                                       .joins(:schedule_candidate)
                                       .where(schedule_candidate: { event_id: params[:event_id] }, user_id: @user.id)
            existing_attend_statuses.each(&:destroy!)
            data.each do |d|
              AttendStatus.create!(
                { schedule_candidate_id: d['schedule_candidate_id'], user_id: @user.id, status: d['status'] }
              )
            end
          rescue ActiveRecord::RecordInvalid => e
            render json: { message: e.message }, status: :bad_request
          else
            render json: { message: 'Successfully updated attend_statuses' }, status: :ok
          end
        end
      end
    end
  end
end
