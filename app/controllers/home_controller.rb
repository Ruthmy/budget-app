class HomeController < ApplicationController
  def index
    if user_signed_in?
      @categories = Category.where(author: current_user)
    else
      redirect_to splash_index_path
    end
  end
end
