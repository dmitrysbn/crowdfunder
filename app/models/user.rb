class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :backed_projects, through: :pledges, source: :project # as a backer
  has_many :owned_projects, class_name: "Project" # as an owner
  has_many :comments

  validates :first_name, :last_name, :email, presence: true, on: :create
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def pledged_amount
    running_total = 0
    pledges.each do |pledge|
      running_total += pledge.dollar_amount
    end
    running_total
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def pledged_for(project)
    running_total = 0
    pledges.each do |pledge|
      if pledge.project == project
        running_total += pledge.dollar_amount
      end
    end
    sprintf "%.2f", running_total
  end

end
