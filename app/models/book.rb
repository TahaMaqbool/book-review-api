class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :book_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

end
