class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy mark_as_best]
  before_action :set_question, only: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @answers = @question.answers.kept
  end

  def new
    @answer = @question.answers.new
    @answer.links.build # or @answer.links.new
  end

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def edit; end

  def update
    @answer.update(answer_params) if current_user.is_author?(@answer)

    set_answers_data
  end

  def destroy
    @answer.soft_delete if current_user.is_author?(@answer)
  end

  def mark_as_best
    @answer.mark_as_best

    set_answers_data

    @best_answer.user.badges.push(@question.badge) if @question.badge
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def set_answers_data
    @question = @answer.question
    @best_answer = @question.best_answer
    @other_answers = @question.answers.where.not(id: @best_answer).kept
  end

  def answer_params
    params.require(:answer).permit(:body,
                                   files: [],
                                   links_attributes: %i[id name url _destroy])
  end
end
