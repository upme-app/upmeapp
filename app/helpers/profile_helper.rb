module ProfileHelper

  def complete_seu_cadastro(value, custom_label = nil)
    if value.nil? or value == ''
      content_tag(:span, (custom_label == nil ? 'Complete seu cadastro' : custom_label), style: 'color: #BDBDBD')
    else
      value
    end
  end

  def areas_de_interesse(user)
    AreaDeInteresse.where(id: user.user_area_de_interesse.map(&:area_de_interesse_id)).pluck(:name).join(', ')
  end

end
