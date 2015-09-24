class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to user_documents_path(current_user.id)
    end
  end

end
