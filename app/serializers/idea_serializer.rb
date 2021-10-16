class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :problem, :region, :field, :rating, :creator, :creator_id, :views, :subscribers

  def creator
    @object.user.username
  end

  def creator_id
    @object.user_id
  end

  def views
    @object.views.all.count()
  end

  def rating
    rate = 0.0
    if object.ratings.count != 0
      @object.ratings.each { |rating|
        rate += rating.rating
      }
      rate /= @object.ratings.count
    end
    rate
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
