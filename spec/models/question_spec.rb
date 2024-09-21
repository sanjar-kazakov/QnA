require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'has many answers' do
    question = create(:question)
    create(:answer, question: question)
    create(:answer, question: question)

    expect(question.answers.count).to eq(2)
  end

  it 'validates presence of title' do
    question = Question.new(body: '123')
    expect(question).to be_invalid
  end

  it 'validates presence of body' do
    question = Question.new(title: '123')
    expect(question).to be_invalid
  end

end
