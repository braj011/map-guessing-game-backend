class ScoreSerializer < ActiveModel::Serializer
  attributes :score, :difficulty, :user
  belongs_to :user

    class UserSerializer < ActiveModel::Serializer
      attributes :name
    end  

end
