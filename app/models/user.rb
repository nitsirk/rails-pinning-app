class User < ActiveRecord::Base
  def self.authenticate(email, password)
    @user = User.find_by(email: email, password: password)
  end

end
