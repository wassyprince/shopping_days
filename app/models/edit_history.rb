class EditHistory < ApplicationRecord
  belongs_to :user
  belongs_to :shopping_list
  belongs_to :item, optional: true

  enum action: { created: 0, updated: 1, deleted: 2 }

  validates :after_name, presence: true, if: -> { created? }
  validates :after_category, presence: true, if: -> { created? || deleted? }
end
