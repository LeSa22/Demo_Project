class EntriesController < ApplicationController
	 before_action :logged_in_user, only: [:show, :create, :destroy]
	 before_action :correct_user,   only: :destroy
  def create
  	@entry = current_user.entries.build(entry_params)
  	if @entry.save
  		flash[:success] = "Entry created!"
      redirect_to root_url
  	else
  		@feed_items = []
  		render 'static_pages/home'
    end
  end
 def show
    @entrys = Entry.paginate(page: params[:page], :per_page=>2)
    @entry = Entry.find(params[:id])
    @comments = @entry.comments.paginate(page: params[:page], per_page: 5)

    if logged_in?
      @comment  = @entry.comments.build
    end
   
  end
  def destroy
    @entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def entry_params
  	params.require(:entry).permit(:content,:title, :picture)
  	
  end
  def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
