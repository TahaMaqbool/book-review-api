class ReminderWorker
  include Sidekiq::Worker

  DATES = %w[24-12-2019 13-12-2019].freeze

  EVENTS = [
    {
      date: '24-12-2019',
      event: 'Faizan Birthday'
    },
    {
      date: '13-12-2019',
      event: 'Test Event'
    }
  ].freeze

  def perform
    date_today = Date.today.strftime('%d-%m-%Y')

    if DATES.include?(date_today)
      event = EVENTS.find { |e| e[:date] == date_today }

      account_sid = Rails.application.credentials[:ACCOUNT_SID]
      auth_token = Rails.application.credentials[:AUTH_TOKEN]

      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      @client.messages.create(
        from: Rails.application.credentials[:WHATSAPP_FROM],
        to: Rails.application.credentials[:WHATSAPP_TO],
        body: "Upcoming event is #{event[:event]} on #{(event[:date].to_date + 1.day).strftime('%d-%m-%Y')}"
      )
    else
      RestClient.get 'https://book-review-api.herokuapp.com/api/v1/books'
    end
  end
end
