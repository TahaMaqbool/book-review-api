# Books controller
module Api
  module V1
    class BooksController < ApplicationController

      before_action :books, only: :index
      before_action :get_user, only: :create
      before_action :book, only: [:show, :update, :destroy]

      def index
        render json: @books, status: :ok
      end

      def create
        book = BookService.new(book_params).save
        if book
          UserMailer.pending_approval(get_user).deliver_now
          render json: book, status: :created
        end
      end

      def show
        render json: @book, status: :ok
      end

      def update
        if @book.update(book_params)
          render status: :no_content
        else
          render json: {error: 'unable to update book information'}, status: :bad_request
        end
      end

      def destroy
        render status: :no_content if @book.destroy
      end

      private

      def books
        @books = Book
                 .category(params[:category])
                 .order(created_at: :desc)
      end

      def book
        @book = Book.find(params[:id]) if params[:id].present?
      end

      def get_user
        User.find(book_params[:user_id])
      end

      def book_params
        params.permit(
            :title,
            :description,
            :author,
            :user_id,
            :category_id,
            :book_img
        )
      end
    end
  end
end
