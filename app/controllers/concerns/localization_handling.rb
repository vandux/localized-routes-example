module LocalizationHandling
  extend ActiveSupport::Concern

  included do
    before_action :redirect_to_locale_from_header
    before_action :redirect_to_valid_locale

    around_action :switch_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def redirect_to_locale_from_header
    return if params[:locale]

    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Extracted '#{locale}'"

    return unless I18n.available_locales.include?(locale)
    return if locale == I18n.default_locale

    if locale
      logger.debug "* Redirecting to '#{locale}'"
      redirect_to url_for(locale: locale)
    end
  end

  def redirect_to_valid_locale
    # should always be params[:locale] at this point unless english
    return unless params[:locale]

    locale = params[:locale]
    
    # if not in list
    return if Routes::SCOPED_LOCALES.include?(locale.to_sym)
    logger.debug "locale #{locale} is not available"

    # strip region and redirect
    locale = locale.scan(/[a-zA-Z]{2}/).first
    logger.debug "stripping region"

    if locale && Routes::SCOPED_LOCALES.include?(locale.to_sym)
      logger.debug "* Redirecting to '#{locale}'"
      redirect_to url_for(locale: locale)
    else
      raise ActionController::RoutingError.new("Not Found") 
    end
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private
  
  def extract_locale_from_accept_language_header
    request.env["HTTP_ACCEPT_LANGUAGE"].scan(Routes.supported_locales_regex).first&.to_sym
  end
end