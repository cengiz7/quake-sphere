class ApplicationController < ActionController::Base
  before_action :set_token

  private

  def set_token
    cookies.encrypted[:token] = "VISITOR:#{SecureRandom.hex(10)}"
  end
end
