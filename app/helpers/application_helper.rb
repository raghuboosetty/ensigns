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
  
end
