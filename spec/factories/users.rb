FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    birth_date { '2000-01-01' }
    occupation_id { 2 } # 1以外のoccupation_idを設定
  end
end
