# frozen_string_literal: true

module Api
  module V1
    module Events
      class UserRelationsController < ApplicationController
        def create
          UsersEvent.create!({ user_id: @user.id, event_id: params[:event_id] })
        rescue ActiveRecord::RecordInvalid => e
          render json: { message: e.message }, status: :bad_request
        else
          render json: { message: 'Successfully created user_event_relations.' }
        end

        def update
          data = params['_json']
          ApplicationRecord.transaction do
            data.each do |d|
              UsersEvent.update!(
                d['id'],
                {
                  label: d['label'].nil? ? 0 : UsersEvent.labels[d['label']],
                  group_id: d['group_id']
                }
              )
            end
          end
        rescue ActiveRecord::RecordInvalid => e
          render json: { message: e.message }, status: :bad_request
        else
          render json: { message: 'Successfully updated user_event_relations.' }
        end
      end
    end
  end
end
