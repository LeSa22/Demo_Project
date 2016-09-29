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

  def edit
  end

  def update
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
end
