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

  # scope :duration, ->(limit1,limit2) { where('duration BETWEEN ? AND ?', limit1,limit2)} if limit1 && limit1

  def self.search(search)
    title_s = search["title"];
    director_s = search["author"];
    duration = search["duration"]

    if search
      where('title LIKE ?', "%#{title_s}%")
      .where('director LIKE?', "%#{director_s}%")
      case duration 
        when 'Under 90 minutes'
          where('runtime_in_minutes < 90')
        when 'Between 90 and 120 min'
          where('runtime_in_minutes > 90 AND runtime_in_minutes <= 120 ')
        when 'Over 120 min'
          where('runtime_in_minutes > 120')
        else
         Movie.all 
      end
    else
      Movie.all
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
