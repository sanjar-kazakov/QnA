FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { "MyString" }
    association :linkable, factory: :question
  end
end
