class EditHistory < ApplicationRecord
  belongs_to :user
  belongs_to :shopping_list
  belongs_to :item, optional: true

  enum action: { created: 0, updated: 1, deleted: 2, list_name_updated: 3,  list_date_updated: 4 }

  validates :after_name, presence: true, if: -> { created? }
end