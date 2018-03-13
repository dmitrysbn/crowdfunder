class User < ActiveRecord::Base
  has_secure_password

  has_many :pledges

  has_many :backed_projects, through: :pledges, source: :project # as a backer
  has_many :owned_projects, class_name: "Project" # as an owner

  validates :password, length: { minimum: 8 }, on: :create
  validates :first_name, :last_name, :email, presence: true, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true
end


# has_many :visitors, :through => :reservations, :source => :user
#
# belongs_to :owner, class_name: "User", foreign_key: 'user_id'
