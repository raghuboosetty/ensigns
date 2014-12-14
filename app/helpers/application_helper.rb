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
end
