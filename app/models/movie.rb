class Movie < ActiveRecord::Base
  has_many :reviews

  mount_uploader :image, ImageUploader, :mount_on => :image


  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    else
      return '0'
    end
  end

  scope :by_title, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :by_director, -> (director) { where('director LIKE ?', "%#{director}%") }
  scope :by_duration, -> (limit1, limit2) { where('runtime_in_minutes BETWEEN ? AND ?', limit1,limit2) }


  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
