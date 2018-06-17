# To serialize in json
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author, :user_id, :book_img, :category_id

  def book_img
    {
      url: object.image_links
    }
  end

end
