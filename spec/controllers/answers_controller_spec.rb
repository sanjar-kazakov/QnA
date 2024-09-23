require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let!(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    before { get :index, params: { question_id: question.id } }
    it 'populates an array of question answers' do
      expect(assigns(:answers)).to eq([answer])
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end
end