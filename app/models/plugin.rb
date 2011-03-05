class Plugin
  
  def initialize
    @data = []
  end
  
  def name(arg=nil)
    set_or_return(:name, arg)
  end
  
  def desc(arg=nil)
    set_or_return(:desc, arg)
  end
  
  def data(option=nil, value=nil)
    if option == nil && value == nil
      @data
    else
      @data << { option => value }
    end
  end
  
  def report
    results = []
    @data.each do |datum|
      d = {
        :key => datum.to_a[0][0],
        :value => datum.to_a[0][1],
        :node => "71140ea02837012e15ee0025bcdd0280",
        :metric => name.parameterize
      }
      results << d
    end
    results
  end
  
  private
  
  def set_or_return(symbol, arg)
    iv_symbol = "@#{symbol.to_s}".to_sym
    
    if arg == nil && self.instance_variable_defined?(iv_symbol) == true
      self.instance_variable_get(iv_symbol)
    else
      self.instance_variable_set(iv_symbol, arg)
    end
  end
  
  def parameterize(string, sep = '-')
    # replace accented chars with their ascii equivalents
    parameterized_string = transliterate(string)
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-_]+/i, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
    end
    parameterized_string.downcase
  end
end