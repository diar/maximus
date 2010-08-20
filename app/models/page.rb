class Page < ActiveRecord::Base
  has_many :child_pages, :class_name => "Page", :foreign_key => "parent_id"
  belongs_to :parent_page, :class_name => "Page", :foreign_key => "parent_id"
  named_scope :level, lambda {|lvl| {:conditions=>['level = ?',lvl],:include=>'child_pages'} }
  validates_presence_of :uri, :title
  validates_uniqueness_of :uri

  def self.get_first_child(page)
    if page.child_pages.size==0
      page
    else
      get_first_child page.child_pages.first
    end
  end

  # получить отформатированный список
  def self.get_list
    parent_pages = [['отсутствует',0]]
    # страницы первого уровня
    Page.level(1).each do |page|
      parent_pages.push [page.title, page.id]
      # страницы второго уровня
      page.child_pages.each do |child_page|
        # страницы третьего уровня
        parent_pages.push ['- '+child_page.title, child_page.id]
        child_page.child_pages.each do |third_page|
          parent_pages.push ['- - '+third_page.title, third_page.id]
        end
      end
    end
    parent_pages
  end
end