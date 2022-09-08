# frozen_string_literal: true

module Api
  module V1
    module Events
      class UserRelationsController < ApplicationController
        def update
          data = params['_json']
          ApplicationRecord.transaction do
            data.each do |d|
              UsersEvent.update!(d['id'], { label: d['label'], group_id: d['group_id'] })
            end
          end
        rescue ActiveRecordError => e
          render json: { message: e.message }, status: :bad_request
        else
          render json: { message: 'Successfully updated user_event_relations.' }
        end
      end
    end
  end
end
