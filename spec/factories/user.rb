FactoryBot.define do
  factory :user do
    name                  {'test'}
    email                 {'test@example.com' }
    password              {'000000'}
    password_confirmation {password}
  end

  factory :shopping_list do
    title { "テストリスト" }
    date  { Date.today }
    association :user
  end
end