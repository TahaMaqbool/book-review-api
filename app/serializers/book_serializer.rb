# To serialize in json
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author, :user_id
end
