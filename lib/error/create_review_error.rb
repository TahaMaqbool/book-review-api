module Error
  class CreateReviewError < CustomError
    def initialize
      super(:create_review_error, 422, 'Unable to create a review')
    end
  end
end