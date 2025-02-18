FactoryBot.define do
  factory :record do
    title { 'テストタイトル' }
    description { 'テスト説明' }
    emotion { '嬉しい' }
    location { 'テスト場所' }
    retention_level_id { 1 } # 適切な retention_level_id を設定
    user { FactoryBot.create(:user) } # userとの関連付け
  end
end
