class CommentsController < ApplicationController
	 before_action :logged_in_user, only: [:create, :destroy, :edit, :update]

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
    @comment = Comment.find(params[:id])
  end
  def edit
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.find(params[:id])
  end
  def update
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end
  def destroy
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end
 

  private
    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
end
