#require 'rubygems'
#require 'em-websocket'
#require 'yajl'
#require 'haml'
#require 'sinatra/base'
#require 'thin'
=begin

=end
$channel = EM::Channel.new
domain = {:host => '0.0.0.0', :port => 8080}

EventMachine.run do
  class Server < Sinatra::Application
    #EventMachine.run

    get '/' do
      haml :index
    end

    post '/' do
      $channel.push "POST>: #{params[:text]}"
    end
  end
  EventMachine::WebSocket.start(domain) do |ws|
      ws.onopen {
        sid = $channel.subscribe { |msg| ws.send msg }
        $channel.push "#{sid} connected!"

        ws.onmessage { |msg|
          $channel.push "<#{sid}>: #{msg}"
        }

        ws.onclose {
          $channel.unsubscribe(sid)
        }
      }

  end
  Server.run!
end
