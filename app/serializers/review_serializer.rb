# To serialize review in json
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :rating, :user_id
end
