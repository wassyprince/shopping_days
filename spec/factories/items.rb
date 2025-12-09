FactoryBot.define do
  factory :item do
    name     { "りんご" }
    quantity { 1 }
    category { "食料品" }
    purchased { false }
    association :shopping_list
  end
end