module Constraints
  class Authenticated
    def matches?(request)
      request.session[:user_id].present?
    end
  end
end
