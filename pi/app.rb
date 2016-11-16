$LOAD_PATH << __dir__

require 'sinatra'
require 'addressable'

require 'launcher'

# TODO: Get rid of a global launcher object
$launcher = nil

def to_with_params(to, params)
  uri = Addressable::URI.new
  uri.path = to
  uri.query_values = params
  to(uri)
end

get "/" do
  erb :index, :locals => {
    :error      => params[:error],
    :launched   => $launcher&.launched?,
    :meeting_id => $launcher&.meeting_id
  }
end

get "/start_meeting" do
  begin
    $launcher = PiJeans::Launcher.new(params[:meeting_id])
    $launcher.start
    redirect to("/")
  rescue => err
    redirect to_with_params("/", :error => err.message)
  end
end

get "/stop_meeting" do
  begin
    $launcher.stop
    redirect to("/")
  rescue => err
    redirect to_with_params("/", :error => err.message)
  end
end
