class Api::V1::ScoresController < ApplicationController

  def index
    # @scores = Score.order(score: :desc)
    # render json: @scores
    @scores_around = Score.find(1).scores_around
    render json: @scores_around
  end

  def create
    @score = Score.new({
      area_id: params[:area_id],
      difficulty: params[:difficulty],
      score: params[:score]
    })
    @score.user = User.find_or_create_by(name: params[:username])
    if @score.save
      render json: score.scores_around
    else
      render json: { error: 'Could not save. ' + @score.errors.full_messages }
    end
  end

end
