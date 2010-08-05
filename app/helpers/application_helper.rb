# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_controller?(c)
    controller.controller_name == c
  end
  def current_page
    @current_page
  end
  # получить родительскую страницу
  def get_page_parent(page)
    if page.level==1
      page
    else
      get_page_parent(page.parent_page)
    end
  end
  # одинаковая ли родительская страница
  def current_parent?(page)
    get_page_parent(page) == get_page_parent(current_page)
  end
  #получить раздел
  def get_page_section(page)
    if page.level==1
      page.child_pages.size>0 ? page.child_pages.first : page
    elsif page.level==2
      page
    else
      page.parent_page
    end
  end
  def current_page?(page)
    current_page.id == page.id
  end
  def current_section?(section)
    get_page_section(current_page).id == section.id
  end
end