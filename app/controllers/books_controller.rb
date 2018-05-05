# Books controller
class BooksController < ApplicationController

  before_action :books, only: :index
  before_action :book, only: :show

  def index
    render json: @books, status: :ok
  end

  def create
    begin
      @book = BookService.new(book_params).save
    rescue error => e
      render json: e
    end
  end

  def show
    render json: @book
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
        :author
    )
  end

end
