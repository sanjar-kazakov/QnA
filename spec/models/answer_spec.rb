require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'belongs to a question' do
    answer = create(:answer)
    question = answer.question
    expect(answer.question).to eq(question)
  end

  it 'validates presence of body' do
    answer = Answer.new(body: nil)
    expect(answer).to be_invalid
  end
end
