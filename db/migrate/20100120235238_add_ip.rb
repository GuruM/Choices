class AddIp < ActiveRecord::Migration
  def self.up
     add_column(:students, :IP, :string)
  end

  def self.down
    remove_column(:students, :IP)
  end
end
