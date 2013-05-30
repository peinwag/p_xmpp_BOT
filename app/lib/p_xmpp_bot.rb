require 'rubygems'
require 'yaml'
require 'logger'
require 'xmpp4r'

class Bot

    attr_accessor :config, :client, :muc

    def initialize(config)
        self.config = config
        self.client = Jabber::Client.new(config[:jid])
        Jabber.debug = true if Jabber.logger = config[:debug]

        self
    end

    def connect
        client.connect
        client.auth(config[:password])
        client.send(Jabber::Presence.new.set_type(:available))
        listen

        self
    end

    def listen
        client.add_message_callback do |message|
            response = Jabber::Message.new(message.from)
            response.type=:chat
            response.body = 'Hi'
            client.send(response)
        end
    end

    def idle
        warn "running"
        loop { sleep 1 }
    end
end

config = YAML.load_file('../config/jabber.yml');
config[:debug] = Logger.new(STDOUT)

Bot.new(config).connect.idle