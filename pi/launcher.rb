module PiJeans
  class Launcher
    attr_reader :meeting_id

    def self.valid_meeting_id?(id)
      id =~ /\A\d+\z/
    end

    def initialize
      # TODO: Detect an already running application and set started = true
    end

    def started?
      @started
    end

    def start(meeting_id)
      raise "cannot start if already started" if started?
      raise ArgumentError, "Meeting ID must be a number" unless self.class.valid_meeting_id?(meeting_id)
      @meeting_id = meeting_id

      puts "LAUNCHING #{meeting_id}"
      @started = true
    end

    def stop
      raise "cannot stop if not already started" unless started?
      puts "STOPPING #{meeting_id}"
      @started = false
    end
  end
end
