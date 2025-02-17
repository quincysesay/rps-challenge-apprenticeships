require 'sinatra/base'
require './lib/computer'
require './lib/game'
require './lib/player'

class RockPaperScissors < Sinatra::Base
  enable :session

  get '/test' do
    'test page'
  end

  before do
    @game = Game.instance
  end

  get '/' do
    erb(:index)
  end

  post '/name' do
    player = Player.new(params[:name])
    @game = Game.create(player)
    redirect '/play'
  end

  get '/play' do
    erb :play
  end

  post '/weapon' do
    @game.player.weapon = params[:weapon]
    redirect('/result')
  end

  get '/result' do
    @game.computer.choose_weapon
    erb(:result)
  end

  get '/thanks' do
    erb(:thanks)
  end

  run! if app_file == $0

end
