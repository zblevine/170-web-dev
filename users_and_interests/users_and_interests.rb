require 'yaml'
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

helpers do
  def count_interests(hsh)
    hsh.keys.reduce(0) { |sum, usr| sum + hsh[usr][:interests].size }
  end
end

before do
  @yaml_hash = YAML.load_file("users.yaml")
  @users = @yaml_hash.keys
end

get "/" do
  @title = "Welcome!"
  erb :home
end

get "/users/:user" do
  @name = params[:user]
  @title = "#{@name.capitalize}'s Page"
  @email = @yaml_hash[@name.to_sym][:email]
  @interests = @yaml_hash[@name.to_sym][:interests].join(', ')

  erb :user
end