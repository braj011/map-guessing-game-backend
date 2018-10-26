class ScoreSerializer < ActiveModel::Serializer
  attributes :score, :difficulty, :username, :rank

  def rank
    object.get_rank + 1
  end

  def username
    object.user.name
  end

end
