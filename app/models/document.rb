require 'aws-sdk-v1'
require 'aws-sdk'

class Document < ActiveRecord::Base
  belongs_to :user

  validates :loan_amount, :interest_rate, :down_payment, presence: true
  validates :loan_amount, :down_payment, numericality: {  only_integer: true, greater_than_or_equal_to: 0 }
  validates :interest_rate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  has_attached_file :pdf,
                    :s3_protocol => "https",
                    :s3_host_name => "s3-us-west-1.amazonaws.com",
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    }
  validates_attachment :pdf, :content_type => { :content_type => 'application/pdf' }

end
