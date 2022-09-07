# rubocop:disable all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

N = 100

ApplicationRecord.transaction do
  users = []
  N.times do |t|
    user = {
      username: Faker::Internet.username,
      email: Faker::Internet.email,
      firebase_id: Faker::Alphanumeric.alphanumeric(number: 32),
      google_id: Faker::Alphanumeric.alphanumeric(number: 32),
      twitter_id: Faker::Alphanumeric.alphanumeric(number: 32)
    }
    puts("Creating user ##{n=t+1}")
    begin
      user = User.create(user)
    rescue ActiveRecord::RecordNotUnique
      # Ignored
    end
    users.push(user)
  end

  events = []
  N.times do |t|
    event_start_at = Faker::Time.between_dates(from: Date.today - 10, to: Date.today - 1)
    event = {
      name: Faker::Address.city,
      start_at: event_start_at,
      end_at: Faker::Time.forward(days: 10),
      image_url: Faker::Internet.url,
      location_name: Faker::Address.community,
      location_address: Faker::Address.full_address,
      location_latitude: Faker::Address.latitude,
      location_longitude: Faker::Address.longitude,
      group_num: Faker::Number.between(from: 2, to: 100),
      total_cost: Faker::Number.between(from: 100, to: 100000),
      questionnaire_url: Faker::Internet.url,
      pattern: Faker::Number.between(from: 1, to: 3),
    }
    puts("Creating event ##{t+1}")
    event = Event.create(event)
    events.push(event)
  end

  (N*4).times do |t|
    user_event_relation_event = events.sample
    user_event_relation = {
      user_id: users.sample.id,
      event_id: user_event_relation_event.id,
      label: Faker::Number.between(from: 1, to: 3),
      group_id: Faker::Number.between(from: 1, to: user_event_relation_event.group_num)
    }
    puts("Creating user_event_relation ##{t+1}")
    UsersEvent.create(user_event_relation)
  end

  schedule_candidates = []
  (N*8).times do |t|
    schedule_candidate = {
      event_id: events.sample.id,
      start_at: Faker::Time.between_dates(from: Date.today - 10, to: Date.today - 1),
      end_at: Faker::Time.forward(days: 10),
    }
    puts("Creating schedule_candidate ##{t+1}")
    schedule_candidate = ScheduleCandidate.create(schedule_candidate)
    schedule_candidates.push(schedule_candidate)
  end

  (N*16).times do |t|
    attend_status = {
      schedule_candidate_id: schedule_candidates.sample.id,
      user_id: users.sample.id,
      status: Faker::Number.between(from: 1, to: 3)
    }
    puts("Creating attend_status ##{t+1}")
    AttendStatus.create(attend_status)
  end
end
