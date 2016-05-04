require 'socket'

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if request_line =~ /favicon/ #makes favicon requests not do anything!
  puts request_line

  req = request_line.split
  #could also do: http_method, path_and_params, http = request_line.split
  http_method = req[0]

  url_parts = req[1].split('?') #req[1] is the back half of the url
  path = url_parts[0]

  params = {}
  param_strings = url_parts[1].split('&')
  param_strings.each do |par|
    param_spl = par.split('=')
    params[param_spl[0]] = param_spl[1] #this array always has two elements
  end

  # other way to get params hash:
  # params_strings.each_with_object({}) do |pair, hash|
  #   key, value = pair.split("=")
  #   hash[key] = value
  # end
  # 
  # can also set aside parsing into its own method, maybe called parse_request

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts request_line
  client.puts "</pre>"

  client.puts "<h1>Rolls!</h1>"
  rolls.times { client.puts "<p>", rand(sides) + 1, "</p>" }

  client.puts "</body>"
  client.puts "</html>"

  client.close
end