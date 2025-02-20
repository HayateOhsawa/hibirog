FactoryBot.define do
  factory :chat do
    message { 'テストメッセージ' } # メッセージの例
    association :user # Userが必要なら、FactoryBotを使用してユーザーを関連付ける
  end
end
