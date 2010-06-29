class Photo < ActiveRecord::Base
  has_many :votes
end
