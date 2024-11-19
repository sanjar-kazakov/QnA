class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_votable

  def vote_up
    vote(1)
  end

  def vote_down
    vote(-1)
  end

  def unvote
    if @votable.voted_by?(current_user)
      @votable.unvote_by(current_user)
      render json: { rating: @votable.rating }
    else
      render json: { errors: ['You have not voted yet'] }, status: :unprocessable_entity
    end
  end

  private

  def vote(value)
    if @votable.voted_by?(current_user)
      render json: { errors: ['You have already voted'] }, status: :unprocessable_entity
    else
      @votable.vote_by(current_user, value)
      render json: { rating: @votable.rating }
    end
  end

  def find_votable
    resource = request.path.split('/')[1] # Получаем 'questions' или 'answers'
    klass = resource.singularize.classify.constantize # Преобразуем в 'Question' или 'Answer'
    @votable = klass.find(params[:id]) # Находим объект по params[:id]
  end
end
