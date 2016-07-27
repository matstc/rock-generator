class Chord
  attr_reader :accidental, :numeral, :quality

  ACCIDENTALS = ['b','#','♯', '♭']
  NUMERALS_TO_NUMBERS = { I: 1, II: 2, III: 3, IV: 4, V: 5, VI: 6, VII: 7 }
  C_MAJOR_SCALE = ['C', 'D', 'E', 'F', 'G', 'A', 'B']
  KEYS = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B'] * 2

  def initialize accidental, numeral, quality=nil, slash=nil
    @accidental = accidental
    @numeral = numeral
    @quality = quality
    @slash = slash
  end

  def self.parse string
    accidental = ACCIDENTALS.include?(string[0]) ? string[0] : nil
    match = string.match(/((?i:#{NUMERALS_TO_NUMBERS.keys.reverse.join("|")}))/)
    raise "Could not parse this chord: #{string}" if match.nil?
    numeral = match.captures.first.to_sym
    quality, slash = match.post_match.split("/")

    if !slash.nil?
      if ACCIDENTALS.include?(slash[0])
        raise "The slash value in this chord is not valid: #{string}" if slash.length < 2
        slash = slash[0] + slash[1, slash.length].upcase
      else
        slash = slash.upcase
      end
    end

    if numeral.nil?
      raise "Could not find the numeral in this chord: #{string}"
    end

    chord = Chord.new accidental, numeral, quality, slash
    puts "WARNING: the chord #{string} was coerced to #{chord.to_s}" if chord.to_s != string
    chord
  end

  def in_the_key_of key
    position = NUMERALS_TO_NUMBERS[@numeral.upcase] - 1
    note = "#{C_MAJOR_SCALE[position]}#{@accidental}"

    steps = KEYS.index(key[0])
    note = KEYS[KEYS.index(simplify(note)) + steps]
    third = @numeral.downcase == @numeral ? 'm' : ''
    
    string = "#{note}#{third}#{@quality}"

    unless @slash.nil?
      slash = Chord.parse @slash
      string += "/#{slash.in_the_key_of(key)}"
    end

    string
  end

  def simplify note
    return "E" if note == "Fb"
    return "B" if note == "Cb"
    note
  end

  def to_s
    "#{@accidental}#{@numeral}#{@quality}#{@slash ? "/#{@slash}" : ''}"
  end
end
