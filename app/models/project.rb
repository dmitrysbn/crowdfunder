class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  
  has_many :backers, through: :pledges, source: :user # backers
  belongs_to :owner, class_name: "User" # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, numericality: { greater_than: 0 }
  validate :start_date_future
  validate :end_date_after_start_date

  def start_date_future
    return unless start_date
    if start_date < Time.now.utc.midnight + 1.day
      errors.add(:start_date, "must be in future")
    end
  end

  def end_date_after_start_date
    return unless start_date && end_date
    if end_date < start_date + 1.day
      errors.add(:end_date, "must be later than start date")
    end
  end
end
