require 'rails_helper'

describe DocumentsController, :type => :controller do

  render_views

  let! (:user) { User.create email: 'test@test.com', password: 'testpassword' }

   before :each do
    sign_in user
   end

  describe "#index" do
    subject { get :index, user_id: user.id }

    it { is_expected.to render_template :index }

    it { is_expected.to have_content 'Documents Dashboard' }
    it { is_expected.to have_content 'Loan Amount'}
    it { is_expected.to have_content 'Down Payment'}
    it { is_expected.to have_content 'Interest Rate'}
    it { is_expected.to have_link 'New Document', new_document_path }
    it { is_expected.to_not have_content '$'}
    it { is_expected.to_not have_content '%'}

    context "when there are documents" do
      let! (:documents) { 3.times.collect { |i| Document.create! "loan_amount" => i, "down_payment" => i, "interest_rate" => i, "user_id" => user.id } }

    it { is_expected.to render_template :_document_table }
    it { is_expected.to render_template :_document_table_row }
      it { is_expected.to have_content '$' }
      it { is_expected.to have_content '%' }
      it { is_expected.to have_link 'View PDF' }
    end

  end

  describe '#create' do
    subject { get :create, user_id: user.id, document: { loan_amount: '100', down_payment: '200', interest_rate: '50' } }

    it { is_expected.to change{ Document.count }.by 1 }
    it "attaches a pdf to document" do
      expect(Document.last.pdf_file_name).to_not eq 'document_1.pdf'
    end
  end

end