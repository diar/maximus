class Photo < ActiveRecord::Base
  belongs_to :album
  has_many :votes
  has_attached_file :image,
    :styles => {
    :big => "1024x1024>",
    :medium => "320x320>",
    :small => "167x167>"
  }
  cattr_reader :per_page
  @@per_page = 6
end