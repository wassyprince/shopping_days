class EditHistoriesController < ApplicationController
  def index
    @edit_histories = EditHistory.includes(:user, :shopping_list, :item).order(created_at: :desc)

    @grouped_histories = @edit_histories.group_by { |h| h.after_category || "その他" }
  end
end
