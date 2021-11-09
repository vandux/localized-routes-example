module ApplicationHelper
  def current_path_in_locale(locale, params)
    locale = nil if locale == :en

    url_for(request.query_parameters.merge(locale: locale))
  end
end
