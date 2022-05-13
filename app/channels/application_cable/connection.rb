module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :visitor_token

    def connect
      # self.client_id = request.params[:client_id]
      puts "token cookie", cookies.encrypted[:token].empty?
      self.visitor_token = find_visitor_token
    end

    def find_visitor_token
      token = cookies.encrypted[:token]
      token.empty? ? reject_unauthorized_connection : token
    end
  end
end
