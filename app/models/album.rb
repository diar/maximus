class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :main_photo, :class_name=>'Photo',:foreign_key=>:main_photo_id
  validates_presence_of :title
  named_scope :visible, {:conditions=>'visible = 1'}
end