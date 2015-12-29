class User < ActiveRecord::Base
  has_many :wiki
  
  enum role: [:standard, :premium, :admin]
  
    after_initialize :init

    def init
      self.role  ||= :standard           #will set the default value only if it's nil
    end
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable    
end
