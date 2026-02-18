class Plan < ApplicationRecord
  has_many :plan_users, dependent: :destroy
  has_many :users, through: :plan_users
  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time < start_time
      errors.add(:base, "終了時間は開始時間より後にしてください")
    end
  end
end
