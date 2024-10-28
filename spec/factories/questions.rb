FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    association :user

    trait :invalid do
      title { nil }
    end

    trait :with_files do
      after(:build) do |question|
        question.files.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'example_file1.txt')),
          filename: 'example_file1.txt',
          content_type: 'text/plain'
        )
        question.files.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'example_file2.txt')),
          filename: 'example_file2.txt',
          content_type: 'text/plain'
        )
      end
    end
  end
end
