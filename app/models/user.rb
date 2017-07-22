class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
end