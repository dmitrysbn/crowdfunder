class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :check_owner

  def check_owner
    if user == project.owner
      errors.add(:owner, "cannot pledge towards their own project!")
    end
  end

end
