class Reward < ActiveRecord::Base
  belongs_to  :project
  validates   :dollar_amount, presence: true
  validates   :dollar_amount, numericality: true
end
