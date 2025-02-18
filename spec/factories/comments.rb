FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    record { nil }
  end
end
