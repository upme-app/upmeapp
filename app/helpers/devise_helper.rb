module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty?

    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h4 class="upme-alert-danger">#{sentence}</h4 >
    </div>
    HTML

    html.html_safe
  end

end
