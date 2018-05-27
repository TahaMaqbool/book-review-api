# Books controller
class BooksController < ApplicationController

  before_action :books, only: :index
  before_action :book, only: [:show, :update, :destroy]

  def index
    render json: @books, status: :ok
  end

  def create
    book = BookService.new(book_params).save
    render json: book, status: :created if book
  end

  def show
    render json: @book, status: :ok
  end

  def update
    if @book.update(book_params)
      render status: :no_content if @book.update(book_params)
    else
      render json: {error: 'unable to update book information'}, status: :bad_request
    end
  end

  def destroy
    render status: :no_content if @book.destroy
  end

  private

  def books
    @books = Book.all.order(created_at: :desc)
  end

  def book
    @book = Book.find(params[:id]) if params[:id].present?
  end

  def book_params
    params.permit(
        :title,
        :description,
        :author,
        :user_id
    )
  end

end
