require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, user:) }
  let(:answer) { create(:answer, question:, user:) }

  describe 'GET #index' do
    let!(:answers) { create_list(:answer, 3, question:, user:) }

    before { get :index, params: { question_id: question.id } }

    it 'populates an array of question answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { question_id: question, id: answer } }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      login(user)
      get :new, params: { question_id: question }
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
      expect(assigns(:answer).question).to eq(question)
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid params' do
      it 'saves a new Answer to the database' do
        expect do
          post :create, params: {
            question_id: question,
            answer: attributes_for(:answer).merge(user_id: user.id), format: :js
          }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to the created answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid params' do
      it 'does not save the answer to the database' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        end.not_to change(Answer, :count)
      end

      it 're-renders the new template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end
end
