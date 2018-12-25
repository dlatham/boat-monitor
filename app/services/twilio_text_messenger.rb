class TwilioTextMessenger
  attr_reader :message, :number

  def initialize(message, number)
    @message = message
    @number = number
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['TWILIO_FROM'],
      to: number,
      body: message
    })
  end
end