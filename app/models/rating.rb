class Rating < ApplicationRecord
  belongs_to :post

  enum mark: %i[1 2 3 4 5]
end
