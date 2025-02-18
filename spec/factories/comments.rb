FactoryBot.define do
  factory :comment do
    comment { 'MyText' }
    user { nil }
    record { nil }
  end
end
