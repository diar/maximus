class Album < ActiveRecord::Base
  has_many :photos
  validates_presence_of :title
  named_scope :visible, {:conditions=>'visible = 1'}
end
