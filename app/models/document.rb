class Document < ActiveRecord::Base
  validates :loan_amount, :interest_rate, :down_payment, presence: true
  validates :loan_amount, :down_payment, numericality: {  only_integer: true, greater_than_or_equal_to: 0 }
  validates :interest_rate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  belongs_to :user
end
