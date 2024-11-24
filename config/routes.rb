Rails.application.routes.draw do
  concern :votable do
    member do
      post :vote_up, to: 'votes#vote_up'
      post :vote_down, to: 'votes#vote_down'
      delete :unvote, to: 'votes#unvote'
    end
  end

  devise_for :users

  root to: 'questions#index'

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true do
      member do
        patch :mark_as_best
      end
    end
  end

  resources :attachments, only: :destroy
  resources :badges, only: %i[destroy index]
end
