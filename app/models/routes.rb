module Routes
  SUPPORTED_LOCALES = I18n.available_locales
  SCOPED_LOCALES = SUPPORTED_LOCALES - [I18n.default_locale]
  
  def self.supported_locales_regex
    /#{supported_locales_regex_map}/.freeze
  end

  def self.scoped_locales_regex
    /#{scoped_locales_regex_map}/.freeze
  end

  private

  def self.supported_locales_regex_map
    SUPPORTED_LOCALES.join("|")
  end
  
  def self.scoped_locales_regex_map
    SCOPED_LOCALES.join("|")
  end
end