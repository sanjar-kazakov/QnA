class BadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_badge, only: :destroy


  def index
    @badges = current_user.badges
  end

  def destroy
    badge_author = @badge.question
    @badge.soft_delete if current_user.is_author?(badge_author)
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
