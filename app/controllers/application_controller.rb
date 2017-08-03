# require "application_responder"
class ApplicationController < ActionController::Base
  # self.responder = ApplicationResponder

  # :nocov:
  def index
    render text: "", layout: true
  end
  # :nocov:

end
