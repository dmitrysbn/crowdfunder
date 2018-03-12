class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  
  has_many :backers, through: :pledges, source: :user # backers
  belongs_to :owner, class_name: "User" # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
end
