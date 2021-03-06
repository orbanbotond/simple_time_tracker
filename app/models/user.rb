class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true, 
                    email: true

  has_many :work_days
  has_many :preferred_working_hours
  has_many :authentication_tokens

  rolify
end
