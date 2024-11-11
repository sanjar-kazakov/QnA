FactoryBot.define do
  factory :link do
    name { 'MyString' }
    url { 'https://gist.github.com/' }
    association :linkable, factory: :question
  end
end
