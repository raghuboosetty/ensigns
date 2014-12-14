module ApplicationHelper
  def admin_image_path
    case current_admin.gender
      when 'f'
        "/assets/avatars/female_avatar.png"
      when 'm'
        "/assets/avatars/male_avatar.png"
      else
        "/assets/avatars/other_avatar.png"
    end
  end

  def status_label(status, title = nil)
    css_class = case status
    when 'in_stock' then 'label-primary'
    when 'reserved', 'partial_pending' then 'label-warning'
    when 'out_stock', 'paid' then 'label-success'
    when 'damaged', 'full_pending' then 'label-danger'
    else
      ''
    end

    content_tag(:span, title || status, class: "label #{css_class}")
  end

  def progress_class(percentage)
    case percentage
      when 0..25
        "progress-bar-danger"
      when 26..50
        "progress-bar-warning"
      when 51..75
        "progress-bar-primary"
      when 100
        "progress-bar-success"
    end
  end

  def progress_label(percentage, title = nil)
    css_class = case percentage
      when 0..25
        "bg-red"
      when 26..50
        "bg-yellow"
      when 51..99.99
        "bg-light-blue"
      when 100
        "bg-green"
      else
        nil        
    end
    content_tag(:span, title || percentage, class: "badge #{css_class}")
  end
end