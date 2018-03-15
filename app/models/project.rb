class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges

  has_many :backers, -> { distinct }, through: :pledges, source: :user # backers
  belongs_to :owner, class_name: "User", foreign_key: 'user_id' # project owner
  has_many :comments
  has_and_belongs_to_many :categories

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

  def pledged_amount
    running_total = 0
    pledges.each do |pledge|
      running_total += pledge.dollar_amount
    end
    running_total
  end

  def self.search(term, hash_category_id)
    if term && hash_category_id[:category_id].present?
      where('title iLIKE ?', "%#{term}%").joins(:categories).where("categories.id = ?", hash_category_id[:category_id]).order(:end_date)
      # ('category_id = ?', hash_category_id[:category_id]).order(:end_date)
    elsif term
      where('title iLIKE ?', "%#{term}%").order(:end_date)
    elsif hash_category_id
      joins(:categories).where("categories.id = ?", hash_category_id[:category_id]).order(:end_date)
    else
      order(:end_date)
    end
  end

  def self.funded
    funded_projects = Project.all.select do |project|
      project.pledged_amount >= project.goal
    end
    funded_projects
  end

end
