module ApplicationHelper

  def page_title
    if @title
      @title
    else
      'Encontre clientes para seus trabalhos de faculdade.'
    end
  end

  def page_image
    if @page_image
      @page_image
    else
      image_url('landing/bg-wide.png')
    end
  end


end
