class PdfDocument < Prawn::Document

  def initialize document, view
    @document = document
    @view = view
    super(top_margin: 50)
    title
    meta_data
    document_info
    copyright
  end

  def title
    text "Docuapp", size: 30, style: :bold
  end

  def meta_data
    move_down 10
    text "Created by #{@document.user.email} on #{@document.created_at.strftime("%m/%d/%Y")}"
  end

  def document_info
    move_down 10
    table [labels, table_row] do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end

  def labels
    [ 'ID', 'Loan Amount', 'Down Payment', 'Interest Rate' ]
  end

  def table_row
    [ @document.id, dollar_amount( @document.loan_amount ), dollar_amount( @document.down_payment ), percent( @document.interest_rate ) ]
  end

  def dollar_amount num
    @view.number_to_currency(num, precision: 0)
  end

  def percent num
    @view.number_to_percentage(num, precision: 2)
  end

  def copyright
    move_down 10
    text "Docuapp brought to you by Herine Chin."
  end

end