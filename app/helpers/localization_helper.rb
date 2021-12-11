module LocalizationHelper
  def current_path_in_locale(locale, options={})
    locale = nil if locale == I18n.default_locale

    url_for(request.query_parameters.merge(locale: locale, **options))
  end

  def hreflang_tags
    links = LocalesScope::SCOPED_LOCALES.map do |locale|
      tag.link(rel: "alternate", hreflang: locale.to_s.downcase, href: current_path_in_locale(locale, only_path: false))
    end

    links.prepend(tag.link(rel: "alternate", hreflang: "x-default", href: current_path_in_locale(I18n.default_locale, only_path: false)))

    links.join.html_safe
  end

  def canonical_url_tag
    tag.link(rel: "canonical", href: current_path_in_locale(I18n.locale, only_path: false))
  end
end