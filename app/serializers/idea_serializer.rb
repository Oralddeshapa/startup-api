class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :problem, :region, :field, :rating
end
