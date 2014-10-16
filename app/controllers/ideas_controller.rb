require 'csv'

class IdeasController < ApplicationController

  before_filter :authenticate_user!
  helper_method :resource

  def index
    @search = Idea.search(params[:search])
    @ideas = @search.page(params[:page]).active.by_latest
    @idea = Idea.new(params[:idea])
  end

  def archived
    @search = Idea.search(params[:search])
    @ideas = @search.page(params[:page]).archived.by_latest
  end

  def new
    @idea = Idea.new(params[:idea])
  end

  def show
    resource
  end

  def create
    idea = current_user.ideas.create(params[:idea])
    if idea.save
      redirect_to ideas_path, notice: "Idea added."
    else
      redirect_to :back, notice: "Unable to create new idea."
    end
  end

  def edit
    resource
  end

  def update
    if resource.update_attributes(params[:idea])
      redirect_to idea_path(resource), notice: "Idea updated."
    else
      redirect_to :back, notice: "Unable to update idea."
    end
  end

  def destroy
    resource.destroy
    redirect_to ideas_path, notice: "Idea deleted."
  end

  def archive
    resource.archived_at = DateTime.now
    if resource.save
      redirect_to ideas_path, notice: "Idea was archived."
    else
      redirect_to ideas_path, notice: "Could not archive."
    end
  end

  def savefile
    header = %w(Priority Title Body Category Up\ Vote Down\ Vote Author Date)
    @ideas = Idea.find(:all, order: 'created_at')
    doc = CSV.generate do |f| 
      f << header
      @ideas.each do |i|
        row = []
        row[0] = i.priority.to_i >= 0 ? i.priority : ""
        row << ActionView::Base.full_sanitizer.sanitize(i.title)
        row << ActionView::Base.full_sanitizer.sanitize(i.body.to_s.strip)
        row << i.category
        row << i.votes.up_vote.count
        row << i.votes.down_vote.count
        row << i.user.email
        row << i.created_at.strftime("%Y-%m-%d %H:%M")
        f << row
      end        
    end
    filename = "ideas_export"
    send_data doc, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=#{filename}.csv"
  end

  def import_form
  end

  def import
    Idea.import(params[:file], current_user.id)
    redirect_to ideas_path, notice: "Ideas imported from file."
  end

  private

  def resource
    @idea ||= Idea.find(params[:id])
  end

end
