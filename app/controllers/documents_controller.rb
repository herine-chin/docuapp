class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @documents = current_user.documents
  end

  def new
    @document = Document.new
  end

end
