class ProgressionsController < ApplicationController
  def index
    @progression = RockProgressionGenerator.new.sample * 4
  end
end
