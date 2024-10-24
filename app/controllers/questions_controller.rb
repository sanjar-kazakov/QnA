class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.kept
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question has been created'
    else
      puts @question.errors.full_messages
      render :new
    end
  end

  def show
    @answer = Answer.new
    @best_answer = @question.best_answer
    @best_answer = nil if @best_answer&.discarded_at.present?
    @other_answers = @question.answers.where.not(id: @best_answer).kept
  end

  def new
    @question = Question.new
  end

  def edit; end

  def update
    @question.update(question_params) if current_user.is_author?(@question)
  end

  def destroy
    @question.soft_delete if current_user.is_author?(@question)
    redirect_to questions_path, notice: 'Your question has been deleted'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
