class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @answers = @question.answers.kept
  end

  def new
    @answer = @question.answers.new
  end

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def edit; end

  def update
    @answer.update(answer_params) if current_user == @answer.user
    @question = @answer.question
  end

  def destroy
    @answer.soft_delete
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
