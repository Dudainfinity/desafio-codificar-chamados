FactoryBot.define do
  factory :ticket do
    sequence(:title) { |n| "Chamado #{n}" }
    description { "Descrição do chamado" }
    priority { :media }
    status { :aberto }
    association :agent
  end
end
