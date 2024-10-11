class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[index new create destroy]
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
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Your answer has been submitted'
    else
      render 'questions/show', flash: { alert: 'Your answer could not be submitted' }
    end
  end

  def destroy
    @answer.soft_delete
    redirect_to question_path(@question), notice: 'Your answer has been deleted'
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
