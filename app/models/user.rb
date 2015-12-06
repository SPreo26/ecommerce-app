class User < ActiveRecord::Base
  has_many :products
  has_many :orders
  has_many :carted_products
  belongs_to :role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    #user.role==admin
  end

  def shopper?
    #user.role==shopper
  end
end
