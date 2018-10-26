class Score < ApplicationRecord
  belongs_to :user
  belongs_to :area
  validates :user_id, :score, :difficulty, :area_id, presence: true
  validates :score, numericality: { less_than_or_equal_to: 2000 }
  validates :difficulty, inclusion: { in: %w(easy medium hard), message: "must be one of easy, medium or hard." }

  def self.ranked_scores
    Score.order(score: :desc, created_at: :asc)
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
    else
      offset = rank - 4
    end
    offset = 0 if offset < 0
    Score.ranked_scores.offset(offset).limit(10)
  end

end
