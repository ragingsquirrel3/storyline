class PublicController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
  end

  def about
    render :js => "alert('Hello Rails');"
  end
end
