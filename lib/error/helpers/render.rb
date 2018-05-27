module Error
  module Helpers
    # For customer errors
    class Render
      def self.json(error, status, message)
        {
          status: status,
          error: error,
          message: message
        }.as_json
      end
    end
  end
end