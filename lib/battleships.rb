require 'sinatra/base'

require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'cell'


class Battleships < Sinatra::Base

GAME = Game.new

set :views, Proc.new { File.join(root, "..", "views") }
enable :sessions

  get '/' do
  	puts session.inspect
 	@name = session[:me]
 	puts GAME.inspect
    erb :index 
  end

  post '/registered' do 
  	session[:me] = params[:player_name]
  	@name = session[:me]
  	GAME.add_player(@name)
    # redirect '/board' if GAME.has_two_players?
  	puts GAME.inspect
  	erb :registered
  end

  get '/registered' do 
    @name = session[:me]
    puts "get page"
    erb :registered
  end

  get '/board' do
    BOARD = Board.new(Cell)
    puts BOARD.inspect
    @board = BOARD.grid
    erb :board
  end


  	# start the server if ruby file executed directly
 	run! if app_file == $0
end
