# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      def index
        events = Event.all.includes(users_events: :user).where(users_events: { user_id: @user.id })
        results = []
        events.each do |event|
          result = {
            id: event.id,
            name: event.name,
            description: event.description,
            start_at: event.start_at,
            end_at: event.end_at,
            image_url: event.image_url,
            location_name: event.location_name,
            location_address: event.location_address,
            location_latitude: event.location_latitude,
            location_longitude: event.location_longitude,
            group_num: event.group_num,
            cost: event.cost,
            cost_type: event.cost_type,
            questionnaire_url: event.questionnaire_url,
            pattern: event.pattern
          }
          results.push(result)
        end
        render json: results
      end

      def show
        event_id = params[:id]
        events = Event.all
                      .includes(users_events: :user, schedule_candidates: { attend_statuses: :user })
                      .where(id: event_id)
        render json: { message: 'event not found' }, status: :bad_request if events.length > 1
        event = events[0]
        # users
        result_users = []
        event.users_events.each do |r|
          result_user = {
            relation_id: r.id,
            user_id: r.user.id,
            username: r.user.username,
            email: r.user.email,
            label: r.label,
            group_id: r.group_id
          }
          result_users.push(result_user)
        end
        # candidates
        result_candidates = []
        event.schedule_candidates.each do |c|
          result_candidates_voters = []
          c.attend_statuses.each do |v|
            result_candidates_voter = {
              user_id: v.user.id,
              username: v.user.username,
              email: v.user.email,
              status: v.status
            }
            result_candidates_voters.push(result_candidates_voter)
          end
          result_candidate = {
            id: c.id,
            start_at: c.start_at,
            end_at: c.end_at,
            voters: result_candidates_voters
          }
          result_candidates.push(result_candidate)
        end
        # results
        results = {
          event: {
            id: event.id,
            name: event.name,
            description: event.description,
            start_at: event.start_at,
            end_at: event.end_at,
            image_url: event.image_url,
            location_name: event.location_name,
            location_address: event.location_address,
            location_latitude: event.location_latitude,
            location_longitude: event.location_longitude,
            group_num: event.group_num,
            cost: event.cost,
            cost_type: event.cost_type,
            questionnaire_url: event.questionnaire_url,
            pattern: event.pattern,
            users: result_users,
            candidates: result_candidates
          },
          user_id: @user.id
        }
        render json: results, status: :ok
      end

      def create
        event_name = params[:name]
        event_description = params[:description]
        ApplicationRecord.transaction do
          event = Event.create({ name: event_name, description: event_description })
          UsersEvent.create({ user_id: @user.id, id: event.id, label: UsersEvent.labels[:owner] })
          render json: {
            message: 'Successfully created event and linked logged-in users to created events.',
            event_id: event.id
          }, status: :created
        rescue ActiveRecord::RecordInvalid => e
          render json: { message: e.message }, status: :bad_request
        end
      end

      def update
        Event.update(
          params[:id],
          {
            name: params[:name],
            description: params[:description],
            start_at: params[:start_at],
            end_at: params[:end_at],
            image_url: params[:image_url],
            location_name: params[:location_name],
            location_address: params[:location_address],
            location_latitude: params[:location_latitude],
            location_longitude: params[:location_longitude],
            group_num: params[:group_num],
            cost: params[:cost],
            cost_type: params[:cost_type],
            questionnaire_url: params[:questionnaire_url],
            pattern: params[:pattern]
          }
        )
      rescue ActiveRecord::RecordInvalid => e
        render json: { message: e.message }, status: :bad_request
      else
        render json: { message: 'Successfully updated event.' }, status: :ok
      end
    end
  end
end
