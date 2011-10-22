# This controller handles the login/logout function of the site.
class SessionsController < Devise::SessionsController
  layout 'admin'
  
end
