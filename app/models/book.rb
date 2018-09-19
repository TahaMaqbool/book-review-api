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

  after_create :notify

  scope :category, ->(name) { joins(:category).where('name = ?',name) if name.present? }
  scope :approved, -> { where(is_approved: true) }

  def image_links
    {
        thumb: self.book_img.url(:thumb),
        medium: self.book_img.url(:medium),
        original: self.book_img.url(:original)
    }
  end

  def self.create(book)
    book = Book.new(book)
    if book.save
      book
    else
      raise Error::CreateBookError
    end
  end

  def notify
    UserMailer.pending_approval_user(User.find(self.user_id)).deliver_later(wait: 1.minute)
    UserMailer.pending_approval_admin(User.admin).deliver_later(wait: 1.minute)
  end
end
