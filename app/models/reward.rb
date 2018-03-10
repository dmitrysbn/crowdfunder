class Reward < ActiveRecord::Base
  belongs_to  :project
  validates :description,:dollar_amount, presence: true
  validates   :dollar_amount, numericality: true
end
