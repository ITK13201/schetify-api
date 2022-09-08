# frozen_string_literal: true

module Api
  module V1
    module Events
      class ScheduleCandidatesController < ApplicationController
        def update
          event_id = params[:event_id]
          existing_candidates = ScheduleCandidate.all.where(event_id:)
          existing_candidates = existing_candidates.map(&:attributes)
          data = params['_json']
          to_add = []
          to_remove = []
          unchanged = []
          # find same data
          data.each do |d|
            existing_candidates.each do |ec|
              unchanged.push(d) if same? d, ec
            end
          end
          # find add data
          data.each do |d|
            exists = false
            unchanged.each do |u|
              exists = true if same? d, u
            end
            to_add.push(d) unless exists
          end
          # find remove data
          existing_candidates.each do |ec|
            exists = false
            unchanged.each do |u|
              exists = true if same? ec, u
            end
            to_remove.push(ec) unless exists
          end
          # model operations
          ApplicationRecord.transaction do
            to_add.each do |ta|
              ScheduleCandidate.create!({ event_id:, start_at: ta['start_at'], end_at: ta['end_at'] })
            end
            to_remove.each do |tr|
              ScheduleCandidate.find(tr['id']).destroy!
            end
          end
        end

        def same?(hash1, hash2)
          hash1['start_at'] == hash2['start_at'] && hash1['end_at'] == hash2['end_at']
        end
      end
    end
  end
end
