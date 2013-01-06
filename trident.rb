require 'sinatra'

class Trident < Sinatra::Base
  get '/' do
    'Hello diner!'
  end
end
