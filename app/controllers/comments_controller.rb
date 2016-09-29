class CommentsController < ApplicationController
	 before_action :logged_in_user, only: [:create]

  def create
  	@entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
    	redirect_to @entry
  	else
    	flash[:danger] = "Error!"
    	redirect_to @entry
  	end
  end

  def show
    @comments = Comment.find(params[:user_id])
  end
  def new
      @entry = Entry.find(params[:entry_id])
      @comment = @entry.comments.new(:parent_id => params[:parent_id])
  end

  def index
    @entry = Entry.find(params[:entry_id])
    @comments = @entry.comments.arrange(:order => :created_at)
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
end
