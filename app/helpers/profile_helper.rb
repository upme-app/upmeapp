module ProfileHelper

  def complete_seu_cadastro(value)
    if value.nil? or value == ''
      content_tag(:span, 'Complete seu cadastro', style: 'color: #BDBDBD')
    else
      value
    end
  end

  def areas_de_interesse(user)
    AreaDeInteresse.where(id: user.user_area_de_interesse.map(&:area_de_interesse_id)).pluck(:name).join(', ')
  end

end
