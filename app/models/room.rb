class Room < ActiveRecord::Base
  validates_presence_of :uri, :title
  validates_uniqueness_of :uri
  typograf :text, :use_br => false
  has_attached_file :photo,
    :styles => {
    :big => "1024x1024>",
    :medium => "320x320>",
    :small => "167x167>"
  }
end
