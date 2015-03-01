require 'sinatra'

post '/form_posted' do
  title = params["Field3"]
  email = params["Field4"]
  content = params["Field6"]

  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_KEY'] # The "key" from step 1
    config.member_token = ENV['TRELLO_TOKEN'] # The token from step 3.
  end

  Trello::Card.create(list_id: "54f345c72e55d08bbb83cb19", name:title, desc: content)
end