# To serialize in json
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author, :user_id, :book_img

  def book_img
    object.image_links
  end

end
