class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  enum user_type: [ :admin, :user ]

  def set_default_type
  	if !self.user_type
  		self.user_type = 1
  		self.save
  	end
  end
end
