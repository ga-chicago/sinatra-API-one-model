class User < ActiveRecord::Base
  # remember that if we didn't arleady have it
  # we'd need to add the bcrypt gem rn
  has_secure_password
end