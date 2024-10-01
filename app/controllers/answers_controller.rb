class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show]
  before_action :set_question, only: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question), notice: 'Your answer has been submitted'
    else
      render 'questions/show', flash: { alert: 'Your answer could not be submitted' }
    end
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
