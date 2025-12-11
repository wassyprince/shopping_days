class EditHistoriesController < ApplicationController
  def index
    @edit_histories = EditHistory.includes(:user, :shopping_list, :item).order(created_at: :desc)
  end
end
