class Api::V1::ScoresController < ApplicationController

  def index
    @scores = Score.first(10)
    render json: @scores
  end

  def create
    @score = Score.new({
      area_id: params[:area_id],
      difficulty: params[:difficulty],
      score: params[:score]
    })
    @score.user = User.find_or_create_by(name: params[:username])
    if @score.save
      render json: @score
    else
      render json: { error: 'Could not save. ' + @score.errors.full_messages }
    end
  end

  private

  def score_params
    params.permit(:area_id, :username, :difficulty, :score)
  end


end
