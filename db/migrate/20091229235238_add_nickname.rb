class AddNickname < ActiveRecord::Migration
  def self.up
     add_column(:students, :nickname, :string)
  end

  def self.down
    remove_column(:students, :nickname)
  end
end
