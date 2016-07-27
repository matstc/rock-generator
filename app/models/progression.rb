class Progression
  attr_reader :numerals, :key

  def initialize
    @generator = RockProgressionGenerator.new
    @numerals = @generator.sample_progression
    @key = @generator.sample_key
  end

  def chords
    RockProgressionGenerator.new.translate(@numerals, @key) * 4
  end

  def key
    if @numerals[0] == "i"
      @key + "m"
    else
      @key
    end
  end
end
