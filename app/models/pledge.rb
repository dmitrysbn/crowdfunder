class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :check_owner

  def check_owner
      if user == project.user
        errors.add(:user, "must not be the owner of the project")
      end
  end

end
