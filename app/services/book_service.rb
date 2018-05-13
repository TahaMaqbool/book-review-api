# For performing operations on book model
class BookService
  attr_reader :title, :description, :author, :user_id

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
    @author = params[:author]
    @user_id = params[:user_id]
  end

  def save
    @book = Book.new(book_create_attributes)
    if @book.save
      @book
    else
      raise 'error saving book'
    end
  end

  private

  def book_create_attributes
    {
        title: title,
        description: description,
        author: author,
        user_id: user_id
    }
  end
end