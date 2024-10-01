require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user:) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3, user:) }

    before { get :index }

    it 'populates an array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { user_id: user, id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      login(user)
      get :new
    end

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      login(user)
      get :edit, params: { id: question }
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid params' do
      it 'saves a new question in the database' do
        expect do
          post :create, params: {
            question: attributes_for(:question) .merge(user_id: user.id)
          }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to the created question' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid params' do
      it 'does not save the question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid) }
        end.not_to change(Question, :count)
      end

      it 're-renders the new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid params' do
      before do
        patch :update, params: { id: question, question: { title: 'New Question', body: 'New Question Description' } }
        question.reload
      end

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq(question)
      end

      it 'changes question attribute title' do
        expect(question.title).to eq('New Question')
      end

      it 'changes question attribute body' do
        expect(question.body).to eq('New Question Description')
      end

      it 'redirects to the updated question' do
        expect(response).to redirect_to question
      end
    end

    context 'with invalid params' do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) } }

      it 'does not change the question title' do
        question.reload
        expect(question.title).to eq('MyString')
      end

      it 'does not change the question body' do
        question.reload
        expect(question.body).to eq('MyText')
      end

      it 're-renders the edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question) }

    before { login(user) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'redirects to the questions list' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
