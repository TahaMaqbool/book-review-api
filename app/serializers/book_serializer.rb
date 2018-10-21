# To serialize in json
class BookSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :author,
             :user_id,
             :book_img,
             :category_id,
             :is_approved

  has_one :category
  has_many :reviews

  def book_img
    {
      name: object.book_img.original_filename,
      url: object.image_links
    }
  end

  def reviews
    object.reviews.order(created_at: :desc)
  end

end
