class Role < ActiveRecord::Base

  has_many :users

  def shopper?
    role_name=="shopper"
  end

  def admin?
    role_name=="admin"
  end

end
