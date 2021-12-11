module LocalesScope
  SUPPORTED_LOCALES = I18n.available_locales
  SCOPED_LOCALES = SUPPORTED_LOCALES - [I18n.default_locale]
  
  def self.supported_locales_regex
    /#{supported_locales_regex_map}/.freeze
  end

  def self.scoped_locales_regex
    /#{scoped_locales_regex_map}/.freeze
  end

  private

  def self.reordered_supported_locales
    # yuck
    SUPPORTED_LOCALES.select {|l| l.to_s.include?('-')} + SUPPORTED_LOCALES.reject {|l| l.to_s.include?('-')} 
  end

  def self.supported_locales_regex_map
    reordered_supported_locales.join("|")
  end
  
  def self.scoped_locales_regex_map
    (reordered_supported_locales  - [I18n.default_locale]).join("|")
  end
end