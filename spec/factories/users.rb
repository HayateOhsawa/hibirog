FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
    birth_date { '2000-01-01' }
    occupation_id { 2 } # 1以外のoccupation_idを設定
  end
end
