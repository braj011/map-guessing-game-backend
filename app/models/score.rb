class Score < ApplicationRecord
  belongs_to :user
  belongs_to :area

  def self.ranked_scores
    Score.order(score: :desc)
  end

  def get_rank
    Score.ranked_scores.index(self)
  end

  def rank_from_bottom
    Score.ranked_scores.count - self.get_rank
  end

  def scores_around
    rank = self.get_rank
    if self.rank_from_bottom <= 6
      offset = rank - (10 - self.rank_from_bottom)
    elsif rank < 4
      offset = 0
    else
      offset = rank-4
    end
    Score.ranked_scores.offset(offset).limit(10)
  end

end
