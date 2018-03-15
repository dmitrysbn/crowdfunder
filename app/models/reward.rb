class Reward < ActiveRecord::Base
  belongs_to  :project
  has_many    :users, through: :pledges
  has_many    :pledges
  validates   :description, :dollar_amount, presence: true
  validates   :dollar_amount, numericality: { greater_than: 0 }
end
