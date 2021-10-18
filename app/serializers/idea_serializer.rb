class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :problem, :region, :field, :rating, :creator, :creator_id, :views, :subscribers

  def creator
    @object.user.username
  end

  def creator_id
    @object.user_id
  end

  def views
    @object.views.count()
  end

  def rating
    count = @object.ratings.count == 0 ? 1 : @object.ratings.count
    @object.ratings.pluck(:rating).sum / count
  end

  def subscribers
    @object.interests.map do |interest|
      user = User.find_by(id: interest.user_id)
      {
       name: user.username,
       mail: user.email
      }
    end
  end
end
