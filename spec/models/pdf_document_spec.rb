require 'rails_helper'

describe PdfDocument do
  context 'when given a document object' do

    let!(:user) { User.create email: 'test@test.com', password: 'testpassword' }
    let!(:document) { Document.create user_id: user.id, loan_amount: 12, interest_rate: 8.88, down_payment: 34 }
    let(:view_context) { ActionController::Base.new.view_context }
    let(:pdf) { PdfDocument.new(document, view_context) }
    let(:pdf_content) {  PDF::Inspector::Text.analyze( pdf.render ) }

    it 'contains the loan amount' do
      expect(pdf_content.strings).to include('$12')
    end

    it 'contains the down_payment' do
      expect(pdf_content.strings).to include('$34')
    end

    it 'contains the interest_rate' do
      expect(pdf_content.strings).to include('8.88%')
    end

  end
end