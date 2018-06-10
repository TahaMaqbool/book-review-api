class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :book_img,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png",
                    storage: :fog,
                    fog_credentials: "#{Rails.root}/config/gce.yml",
                    fog_directory: "book-review-bucket",
                    path: ":rails_root/public/images/:style/:basename.:extension",
                    url: "/images/:style/:basename.:extension"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

  scope :category, ->(name) { joins(:category).where('name = ?',name) if name.present? }

  def image_links
    {
        thumb: self.book_img.url(:thumb),
        medium: self.book_img.url(:medium),
        original: self.book_img.url(:original)
    }
  end

end
