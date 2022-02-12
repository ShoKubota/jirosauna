# frozen_string_literal: true

module ApplicationHelper
  def top_nav
    if current_page?(root_path)
      'bg-opacity-0'
    else
      'shadow-lg bg-opacity-90'
    end
  end
end
