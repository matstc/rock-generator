class ProgressionsController < ApplicationController
  def index
    @progression = Progression.new
  end
end
