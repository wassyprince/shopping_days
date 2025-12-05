class Notification < ApplicationRecord
  belongs_to :user
  attribute :enabled, :boolean, default: false
end
