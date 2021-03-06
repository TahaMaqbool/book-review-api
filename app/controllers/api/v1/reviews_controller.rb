# Reviews controller
module Api
  module V1
    class ReviewsController < ApplicationController

      before_action :authenticate_api_v1_user!
      skip_before_action :authenticate_api_v1_user!, only: [:index], raise: false
      before_action :reviews, only: :index
      before_action :review, only: [:show, :update, :destroy]
      before_action :book, only: :create

      def index
        render json: @reviews, status: :ok
      end

      def create
        review = @book.reviews.create(review_params.merge(user_id: current_user.id))
        render json: review, status: :created and return
        raise Error::CreateReviewError
      end

      def show
        render json: @review, status: :ok
      end

      def update
        if authorized_user
          @review.update(review_params)
          render json: @review, status: :ok and return
        end
        render json: { error: 'unable to update review' }, status: :bad_request
      end

      def destroy
        if authorized_user
          @review.destroy
          render status: :no_content and return
        end
        render json: { errors: ['unable to delete review'] }, status: :bad_request
      end

      private

      def reviews
        @reviews = Review.order(created_at: :desc)
      end

      def book
        @book = Book.find(params[:book_id]) || not_found
      end

      def review
        @review = Review.find(params[:id]) || not_found
      end

      def authorized_user
        @review.user == current_user || current_user.admin
      end

      def review_params
        params.permit(:comment, :rating)
      end
    end
  end
end
