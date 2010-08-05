class Page < ActiveRecord::Base
  has_many :child_pages, :class_name => "Page", :foreign_key => "parent_id"
  belongs_to :parent_page, :class_name => "Page", :foreign_key => "parent_id"

  def self.get_first_child(page)
    if page.child_pages.size==0
      page
    else
      get_first_child page.child_pages.first
    end
  end
end