class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :problem, :region, :field, :rating, :creator, :creator_id

  def creator
    User.find(@object.user_id).username
  end

  def creator_id
    User.find(@object.user_id).id
  end
end
