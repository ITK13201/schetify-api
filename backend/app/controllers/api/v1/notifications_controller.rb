# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        notifications = @user.notifications
        results = []
        notifications.each do |notification|
          result = {
            event_id: notification.event_id,
            event_name: notification.event.name,
            title: notification.title,
            contents: notification.contents,
            created_at: notification.created_at,
          }
          results.push(result)
        end
        render json: results
      end
    end
  end
end
