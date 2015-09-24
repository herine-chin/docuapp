class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|

      t.belongs_to  :user, index: true
      t.integer     :loan_amount
      t.decimal     :interest_rate
      t.integer     :down_payment
      t.timestamps  null: false

    end
  end
end
