def launch_app
  # TODO: Figure out how to deal with an already open BlueJeans app
  #   that's not on the main screen

  App("Blue Jeans").tap do |app|
    sleep(1)
    app.focus
  end
end

def join_meeting(app, meeting_id)
  app.window.click(Pattern("join_meeting.png").similar(0.80))
  sleep(1) # Wait for the animation to complete so we don't misclick

  # TODO: Find and click on "Participant"

  app.window.type("enter_meeting_id.png", meeting_id)
  app.window.click("lets_go.png")
  sleep(1) # Wait for the animation to complete and camera to start

  # TODO: Ensure that the Camera and Mic are on or off

  app.window.click("join_meeting_green.png")
end

def usage
  puts "usage: runsikulix -r #{__FILE__} -- meeting_id"
end

meeting_id = ARGV[0]
meeting_id ||= input("Enter the meeting ID number:")
if meeting_id !~ /\A\d+\z/
  puts "ERROR: meeting ID must be a number"
  usage
  exit(1)
end

app = launch_app
join_meeting(app, meeting_id)
