# Books controller
module Api
  module V1
    class BooksController < ApplicationController

      before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy, :approve, :reject]
      before_action :books, only: :index
      before_action :get_user, only: :create
      before_action :book, only: [:show, :update, :destroy, :approve, :reject]

      def index
        render json: @books, status: :ok
      end

      def create
        book = Book.create(book_params)
        render json: book, status: :created if book
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

      def approve
        if @book.update(is_approved: true)
          render status: :no_content
        else
          render json: {error: 'unable to approve book'}, status: :bad_request
        end
      end

      def reject
        if @book.update(is_approved: false)
          render status: :no_content
        else
          render json: {error: 'unable to reject book'}, status: :bad_request
        end
      end

      private

      def books
        @books = Book
                 .category(params[:category])
                 .approved
                 .order(created_at: :desc)
      end

      def book
        return if params[:id].blank?
        @book = Book.find(params[:id])
        @book.is_approved ? @book : not_found
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
