class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  def average
    (ratings.sum(:mark).to_d / ratings.count)
  end
end
