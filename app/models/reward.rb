class Reward < ActiveRecord::Base
  belongs_to  :project
  has_many    :users, through: :pledges
  has_many    :pledges
  validates   :description, :dollar_amount, presence: true
  validates   :dollar_amount, numericality: { greater_than: 0 }
  validate    :times_claimed_under_limit?

  def times_claimed_under_limit?
    unless times_claimed <= claim_limit
      errors.add(:claim_limit, "has been exceeded")
    end
  end
end
