# frozen_string_literal: true

class UsersEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  enum :label, { readonly: 0, editor: 1, owner: 2 }, prefix: true, default: :readonly
end
