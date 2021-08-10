class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :problem, :region, :field, :rating, :creator, :creator_id

  def creator
    @object.user.username
  end

  def creator_id
    @object.user_id
  end
end
