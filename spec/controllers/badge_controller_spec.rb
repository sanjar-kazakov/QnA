require 'rails_helper'

RSpec.describe BadgesController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user:) }
  let!(:badges) { create_list(:badge, 3, question:, user:) }

  before do
    login(user)
  end

  describe 'GET #index' do
    before { get :index }

    it 'populates an array of badges' do
      expect(assigns(:badges)).to match_array(badges)
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'DELETE #destroy' do
    let(:first_badge) { badges.first }
    let(:last_badge) { badges.last }

    it 'deletes the badge' do
      delete :destroy, params: { id: first_badge }, format: :js

      expect(Badge.find(first_badge.id).discarded_at).not_to be_nil
      expect(Badge.find(last_badge.id).discarded_at).to be_nil
    end
  end
end