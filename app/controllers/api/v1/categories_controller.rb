# Books controller
module Api
  module V1
    class CategoriesController < ApplicationController

      before_action :categories, only: :index

      def index
        render json: @categories, status: :ok
      end


      private

      def categories
        @categories = Category.order(created_at: :desc)
      end

    end
  end
end
