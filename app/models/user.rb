class User < ActiveRecord::Base
  easy_roles :roles
  
  acts_as_authentic do |u|
    u.validate_login_field = false
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    UserMailer.password_reset_instructions(self).deliver
  end  

end
