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

    it 'assigns a new link to @answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
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
            answer: attributes_for(:answer).merge(user_id: user.id), format: :json
          }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to the created answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :json }
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'does not save the answer to the database' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :json }
        end.not_to change(Answer, :count)
      end

      it 're-renders the create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :json }
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid params' do
      before { patch :update, params: { id: answer, answer: { body: 'new body' }, format: :js } }

      it 'changes @answer attributes' do
        answer.reload
        expect(answer.body).to eq('new body')
      end

      it 'renders the update template' do
        expect(response).to render_template :update
      end
    end

    context 'with invalid params' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js }

      it 'does not change @answer attributes' do
        old_body = answer.body
        answer.reload
        expect(answer.body).to eq(old_body)
      end

      it 'renders the update template' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'PATCH #mark_as_best' do
    before do
      login(user)
      patch :mark_as_best, params: { id: answer, format: :js }
    end

    it 'marks the answer as best' do
      question.reload
      expect(question.best_answer.id).to eq(answer.id)
    end

    it 'renders the mark_as_best template' do
      expect(response).to render_template :mark_as_best
    end
  end
end
