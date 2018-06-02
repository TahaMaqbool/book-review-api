# For performing operations on book model
class BookService
  attr_reader :title, :description, :author, :category_id, :user_id

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
    @author = params[:author]
    @category_id = params[:category_id]
    @user_id = params[:user_id]
  end

  def save
    @book = Book.new(book_create_attributes)
    if @book.save
      @book
    else
      raise Error::CreateBookError
    end
  end

  private

  def book_create_attributes
    {
        title: title,
        description: description,
        author: author,
        user_id: user_id,
        category_id: category_id
    }
  end
end