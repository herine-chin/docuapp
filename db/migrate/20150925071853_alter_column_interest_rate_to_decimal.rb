class AlterColumnInterestRateToDecimal < ActiveRecord::Migration
    def self.up
    change_table :documents do |t|
      t.change :interest_rate, :decimal
    end
  end
  def self.down
    change_table :documents do |t|
      t.change :interest_rate, :integer
    end
  end
end
