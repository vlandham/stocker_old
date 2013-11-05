module Stocker
  # expands text strings that are meant to
  # be floats. 'B' is billion 'M' is million.
  # %'s are converted to decimal.
  def expand_number raw_number
    raw_number.strip!
    val = raw_number
    if raw_number =~ /([-+]?\d+\.?\d*)B/
      val = $1.to_f * 1000000000.0
    elsif raw_number =~ /([-+]?\d+\.?\d*)M/
      val = $1.to_f * 1000000.0
    elsif raw_number =~ /([-+]?\d+\.?\d*)%/
      val = $1.to_f / 100.0
    else
      val = val.to_f
    end
    val
  end

  def to_key name
    key = name.downcase
    key = key.strip.gsub(/(\s+|\/)/, "_")
    key
  end

  def clean_whitespace string
    string = string.strip.gsub("\n", " ")
    # string = string.gsub(/s+/, " ")
    string
  end
end
