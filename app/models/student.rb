class Student < ActiveRecord::Base
  belongs_to :option, :counter_cache => true
  validates_presence_of :name
  validates_presence_of :nickname
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :id
end
