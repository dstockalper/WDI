require 'rack'
require_relative 'main'

app = App.new
app = Rack::ShowExceptions.new(app)
app = Rack::Reloader.new(app)
app = Rack::ShowStatus.new(app)
app = Rack::Static.new(app, {
    :urls => ["/public"]
})
app = Rack::Session::Cookie.new(app)

Rack::Handler::WEBrick.run app
