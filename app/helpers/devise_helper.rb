module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    #messages = resource.errors.full_messages.map { |msg| content_tag(:li, content_tag(:small, msg)) }.join
    messages = resource.errors.details.keys.map { |attr| content_tag(:li, content_tag(:small, resource.errors.full_messages_for(attr).first)) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-block devise-bs">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <small>Há erro(s) que devem ser corrigido(s):</small>
      <ul>#{messages}</ul>
    </div>
    HTML
    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end