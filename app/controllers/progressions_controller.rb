class ProgressionsController < ApplicationController
  def index
    generator = RockProgressionGenerator.new
    @key = generator.sample_key
    @numerals = generator.sample_progression
    @progression = generator.translate(@numerals, @key) * 4
  end
end
