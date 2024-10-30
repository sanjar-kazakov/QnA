FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    association :question
    association :user

    trait :invalid do
      body { nil }
    end

    trait :with_files do
      after(:build) do |answer|
        answer.files.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'example_file1.txt')),
          filename: 'example_file1.txt',
          content_type: 'text/plain'
        )
        answer.files.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'example_file2.txt')),
          filename: 'example_file2.txt',
          content_type: 'text/plain'
        )
      end
    end
  end
end
