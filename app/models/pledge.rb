class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate  :check_owner
  validate  :claim_under_limit?

  def check_owner
    if user == project.owner
      errors.add(:owner, "cannot pledge towards their own project!")
    end
  end

  def claim_under_limit?
    if reward && reward.times_claimed > reward.claim_limit
      errors.add(:claim_limit, "has been exceeded.")
    end
  end

end
