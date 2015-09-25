class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :process_params , :only => [:create] # :edit

  def index
    @documents = current_user.documents.reverse
  end

  def new
    @document = Document.new
    @modal_title = "Add New Document"
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      generate_pdf
      @document.pdf = File.open("#{Rails.root}/app/pdfs/document_#{@document.id}.pdf")
      @document.save
      delete_pdf
    else
      @modal_title = "Add New Document"
      render :new
    end
  end

  def generate_pdf
    pdf = PdfDocument.new(@document)
    pdf.render_file "#{Rails.root}/app/pdfs/document_#{@document.id}.pdf"
  end

  def delete_pdf
    File.delete("#{Rails.root}/app/pdfs/document_#{@document.id}.pdf")
  end

  private

  def document_params
    params.require(:document).permit(:loan_amount, :interest_rate, :down_payment, :user_id)
  end

  def process_params
    document = params[:document]

    if !document[:loan_amount].empty?
      params[:document][:loan_amount] = document[:loan_amount].to_i
    end

    if !document[:interest_rate].empty?
      params[:document][:interest_rate] = document[:interest_rate].to_i
    end

    if !document[:down_payment].empty?
      params[:document][:down_payment] = document[:down_payment].to_i
    end

    params[:document][:user_id] = params[:user_id].to_i
  end

end
