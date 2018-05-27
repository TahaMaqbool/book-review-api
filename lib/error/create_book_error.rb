module Error
  class CreateBookError < CustomError
    def initialize
      super(:create_book_error, 422, 'Unable to create a book')
    end
  end
end