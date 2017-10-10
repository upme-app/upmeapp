module ApplicationHelper

  def page_title
    if @title
      @title
    else
      'Encontre clientes para seus trabalhos de faculdade.'
    end
  end

  def page_description
    if @page_description
      @page_description
    else
      'Comece profissional. Encontre clientes para seus trabalhos da faculdade e organize suas entregas como um profissional.'
    end
  end

  def page_image
    if @page_image
      @page_image
    else
      image_url('landing/bg-wide.png')
    end
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        return "alert-success"
      when :error
        return "alert-danger"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def profilepic(user)
    if user.profilepicurl.nil?
      'app/profile_empty.png'
    else
      user.profilepicurl
    end
  end

  def logourl(user)
    if user.logourl.nil?
      'app/logo-empty.png'
    else
      user.logourl
    end
  end

  def form_error(msg)
    if msg
      html = <<-HTML
      <div>
        <h5 class="label-red">#{msg.join(', ')}</h5>
      </div>
      HTML

      html.html_safe
    end

  end

end
