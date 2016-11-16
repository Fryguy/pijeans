module PiJeans
  class Launcher
    attr_reader :meeting_id

    def self.valid_meeting_id?(id)
      id =~ /\A\d+\z/
    end

    def initialize(meeting_id)
      raise ArgumentError, "Meeting ID must be a number" unless self.class.valid_meeting_id?(meeting_id)
      @meeting_id = meeting_id
    end

    def launched?
      @launched
    end

    def start
      puts "LAUNCHING #{meeting_id}"
      @launched = true
    end

    def stop
      puts "STOPPING #{meeting_id}"
      @launched = false
    end
  end
end
