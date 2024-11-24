# spec/helpers/application_helper_spec.rb
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:answer) { create(:answer, question:, user: author) }

  before do
    allow(helper).to receive_messages(user_signed_in?: true, current_user: author)
  end

  describe '#author?' do
    context 'when user is the author of the resource' do
      it 'returns true' do
        expect(helper.author?(author, question)).to be true
      end
    end

    context 'when user is not the author of the resource' do
      it 'returns false' do
        expect(helper.author?(user, question)).to be false
      end
    end
  end

  describe '#question_author?' do
    let(:another_answer) { create(:answer, question:, user: author) }

    context 'when user is the author of the question and the answer is not the best' do
      it 'returns true' do
        expect(helper.question_author?(author, question, another_answer, answer)).to be true
      end
    end

    context 'when user is not the author of the question' do
      it 'returns false' do
        expect(helper.question_author?(user, question, another_answer, answer)).to be false
      end
    end

    context 'when the answer is the best' do
      it 'returns false' do
        question.update(best_answer_id: answer.id)
        expect(helper.question_author?(author, question, answer, answer)).to be false
      end
    end
  end
end
