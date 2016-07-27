class RockProgressionGenerator
  MAIN_KEYS = ['C', 'D', 'E', 'F', 'G', 'A'].flat_map {|k|[k,"#{k}m"]}

  PROGRESSIONS = [
    ['I', 'I7', 'IV', 'IV/V'],
    ['I', 'I', 'bVII', 'IV'],
    ['I', 'IV', 'vi', 'bVII'],
    ['I', 'V', 'vi', 'IV'],
    ['I', 'bVI', 'bVII', 'I'],
    ['i', 'bVI', 'bVII', 'i'],
    ['i', 'i/VII', 'bIII/bVII', 'IV/VI', 'bVI', 'VII'],
    ['vi', 'IV', 'ii', 'V']
  ]

  def sample_progression
    PROGRESSIONS.sample
  end

  def sample_key
    MAIN_KEYS.sample
  end

  def translate progression, key
    progression.map {|s| Chord.parse(s)}.map {|c| c.in_the_key_of(key)}
  end

end
