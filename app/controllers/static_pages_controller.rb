class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  	 @entry = current_user.entries.build if logged_in?
  	 @feed_items = current_user.feed.paginate(page: params[:page], per_page:2)
    else
      @entry = Entry.paginate(page: params[:page], per_page:2)
    end
  end

  def help
  end
  
  def about
  end
end
