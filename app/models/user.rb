class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password
  after_destroy :delete_reviews

  def delete_reviews
    reviews.destroy_all
    
  end

  def full_name
    "#{firstname} #{lastname}"
  end

end
