require 'drb'
require 'drb/acl'
require 'thread'

module Adhearsion
  class Initializer

    class DrbInitializer

      class << self

        def start
          config = Adhearsion::AHN_CONFIG.drb
          DRb.install_acl ACL.new(config.acl) if config.acl
          DRb.start_service "druby://#{config.host}:#{config.port}", Adhearsion::DrbDoor.instance
          ahn_log "Starting DRb on #{config.host}:#{config.port}"
        end
  
        def stop
          DRb.stop_service
        end
      end
    end
  end
end
