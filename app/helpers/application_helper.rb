module ApplicationHelper
  def full_title(page_title)
    base_title = 'Happiness'
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end
end
