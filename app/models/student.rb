class Student < ActiveRecord::Base
  belongs_to :option, :counter_cache => true
  validates_format_of :nickname, :with => /^[A-Za-z\.\"\,\- ]+$/, :message => "Friendly name is invalid. Only letters and spaces allowed!"
end
