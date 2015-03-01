require 'dotenv'
require 'rest-client'
require 'json'
require 'twilio-ruby'
require 'trello'

Dotenv.load

def geocoding_example
  url = "https://maps.googleapis.com/maps/api/geocode/json"

  response = RestClient.get url, 
  {:params => {address: "5 place Sainte Gudule, 1000 Bruxelles", key: ENV['GOOGLE_GEOCODE_KEY'] }}

  data = JSON.parse(response)
end

def meetup_example
  key = ENV['MEETUP_KEY']

  response = RestClient.get 'https://api.meetup.com/2/rsvps', 
  {:params => {sign: true, key: key, event_id: "220347299" }}

  data = JSON.parse(response)

  data["results"].each do |r| 
    puts r["member"]["name"]
  end
end

def trello_get_example
  token = ENV['TRELLO_TOKEN']
  key = ENV['TRELLO_KEY']

  response = RestClient.get 'https://api.trello.com/1/boards/PVsXyxnK', 
  {:params => {key: key, token: token, cards: "all" }}
  JSON.parse(response)
end

def trello_post_example

  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_KEY'] # The "key" from step 1
    config.member_token = ENV['TRELLO_TOKEN'] # The token from step 3.
  end

  Trello::Card.create(list_id: "54f345c72e55d08bbb83cb19", name:"test", desc: "Long test")

  # response = RestClient.post 'https://api.trello.com/1/cards', 
  # {:params => {key: key, token: token, idList: "54a94802fc3880e585d15e39", name: "New Card", desc: "Ready to start" }}
  # JSON.parse(response)
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

p trello_post_example