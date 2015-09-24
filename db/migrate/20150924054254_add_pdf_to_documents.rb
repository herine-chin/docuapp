class AddPdfToDocuments < ActiveRecord::Migration
  def self.up
    add_attachment :documents, :pdf
  end

  def self.down
    remove_attachment :documents, :pdf
  end
end
