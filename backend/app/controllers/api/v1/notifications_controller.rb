# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      skip_before_action :find_user, only: :index

      def index
        notifications = Notification.includes(event: { users_events: :user })
                                    .select('events.id as event_id, events.name as event_name, title, contents, notifications.created_at') # rubocop:disable Layout/LineLength
                                    .where(user: { firebase_id: params[:uid] })
        render json: notifications
      end
    end
  end
end
