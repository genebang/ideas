class VotesController < ApplicationController

  before_filter :check_self_vote

  def up
    up_value = 1 # can use method to determine vote value
    vote = @idea.votes.build(value: up_value, user_id: current_user.id, idea_id: @idea.id)
    if vote.save
      redirect_to idea_path(@idea), notice: "Up vote added!"
    else
      redirect_to idea_path(@idea), notice: "Vote already counted."
    end
  end

  def down
    down_value = -1 # can use method to determine vote value
    vote = @idea.votes.build(value: down_value, user_id: current_user.id, idea_id: @idea.id)
    if vote.save
      redirect_to idea_path(@idea), notice: "Down vote added!"
    else
      redirect_to idea_path(@idea), notice: "Vote already counted."
    end
  end

  private

  def check_self_vote
    @idea = Idea.find(params[:idea_id])
    if current_user.id == @idea.user_id
      redirect_to idea_path(@idea), notice: "You cannot vote on your own idea."
    end
  end

end
