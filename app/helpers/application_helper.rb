module ApplicationHelper
  def author?(current_user, resource)
    user_signed_in? && current_user.id == resource.user_id
  end

  def question_author?(current_user, question, best_answer, answer)
    user_signed_in? && current_user.id == question.user_id && best_answer&.id != answer.id
  end
end
