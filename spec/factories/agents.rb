FactoryBot.define do
  factory :agent do
    sequence(:name) { |n| "Responsável #{n}" }
  end
end
