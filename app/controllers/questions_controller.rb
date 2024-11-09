class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]

  def index
    @questions = Question.kept
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question has been created'
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
    @answer.links.build
    @best_answer = @question.best_answer
    @best_answer = nil if @best_answer&.discarded_at.present?
    @other_answers = @question.answers.where.not(id: @best_answer).kept
    @badge = @question.badge
  end

  def new
    @question = Question.new
    @question.build_badge
    @question.links.build # or @question.links.new
  end

  def edit
    @question.build_badge unless @question.badge
    @badge = @question.badge
  end

  def update
    @question.update(question_params) if current_user.is_author?(@question)
  end

  def destroy
    @question.soft_delete if current_user.is_author?(@question)
    redirect_to questions_path, notice: 'Your question has been deleted'
  end

  private

  def find_question
    @question = Question.with_attached_files.includes(:links).find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :title,
      :body,
      files: [],
      links_attributes: %i[id name url _destroy],
      badge_attributes: %i[id name badge_image _destroy]
    )
  end

  def set_question

  end
end
