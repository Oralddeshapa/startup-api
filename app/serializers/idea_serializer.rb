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
    0
  end

  def subscribers
    subs = []
    @object.interests.each { |interest|
      user = User.find_by(id: interest.user_id)
      subs += [{
         name: user.username,
         mail: user.email
        }]
    }
    subs
  end
end
