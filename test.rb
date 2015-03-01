require 'dotenv'
require 'rest-client'
require 'json'
require 'twilio-ruby'

Dotenv.load

def meetup_example
  key = ENV['MEETUP_KEY']

  response = RestClient.get 'https://api.meetup.com/2/rsvps', 
  {:params => {sign: true, key: key, event_id: "220347299" }}

  data = JSON.parse(response)

  data["results"].each do |r| 
    puts r["member"]["name"]
  end
end

def trello_example
  token = ENV['TRELLO_TOKEN']
  key = ENV['TRELLO_KEY']

  response = RestClient.get 'https://api.trello.com/1/boards/kxWSvBft', 
  {:params => {key: key, token: token, cards: "all" }}
  JSON.parse(response)
end

def twilio_example
  account_sid = ENV['TWILIO_SID']
  auth_token = ENV['TWILIO_AUTHTOKEN']

  client = Twilio::REST::Client.new account_sid, auth_token
  from = "+32460201157" # Your Twilio number
  to =   "+32486899652"
  client.account.messages.create(
    :from => from,
    :to => to,
    :body => "Hey Martin, this is my message from Twilio using Ruby"
  )
end

meetup_example