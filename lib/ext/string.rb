class String
  # strings de cada classe de equivalência para testes
  INT_STRING = "3"
  EMAIL_STRING = "genaina@email.com"
  FLOAT_STRING = "3.14"
  PHONE_STRING = "(61) 98999-9999"
  DATE_STRING = "12/01/1997"

  CUSTOM_METHODS = %w(is_i? is_email? is_float? is_phone? is_date?)

  EQUIVALENCE_CLASSES = {
    "is_i?" => "INTEGER",
    "is_email?" => "EMAIL",
    "is_float?" => "FLOAT",
    "is_phone?" => "PHONE",
    "is_date?" => "DATE",
  }

  STRINGS_EQUIVALENCE_CLASSES = {
      "is_i?" => String::INT_STRING,
      "is_email?" => String::EMAIL_STRING,
      "is_float?" => String::FLOAT_STRING,
      "is_phone?" => String::PHONE_STRING,
      "is_date?" => String::DATE_STRING,
  }

  def is_i?
    /\A[-+]?\d+\z/ === self
  end

  def is_email?
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i === self
  end

  def is_float?
    self.to_f.to_s === self
  end

  def is_phone?
    /^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$/ === self ||
        /^\([1-9]{2}\)(?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$/ === self
  end

  def is_date?

  end
end