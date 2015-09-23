class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @documents = current_user.documents
  end

end
