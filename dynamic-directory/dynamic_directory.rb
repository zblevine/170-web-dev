require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Dynamic Directory"
  @reverse = params['reverse']
  @globbed = Dir.glob('public/*').map { |file| File.basename(file) }.sort
  @globbed.reverse! if @reverse

  erb :home
end