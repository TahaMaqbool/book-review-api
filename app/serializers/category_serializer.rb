# To serialize in json
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
end
