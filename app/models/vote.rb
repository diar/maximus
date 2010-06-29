class Vote < ActiveRecord::Base
  belongs_to :photo
  validates_presence_of :user_name
end
