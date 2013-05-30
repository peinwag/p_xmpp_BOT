require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'logger'
require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'

class Bot

    attr_accessor :config, :client, :muc

    def initialize(config)
        self.config = config
        self.client = Jabber::Client.new(config[:jid])
        self.muc = Jabber::MUC::SimpleMUCClient.new(client)
        Jabber.debug = true if Jabber.logger = config[:debug]

        self
    end

    def connect
        client.connect
        client.auth(config[:password])
        client.send(Jabber::Presence.new.set_type(:available))

        self
    end

    def idle
        warn "running"
        loop { sleep 1 }
    end
end

config = YAML.load_file('../config/jabber.yml');
config[:debug] = Logger.new(STDOUT)

Bot.new(config).connect.idle