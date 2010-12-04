class CreateDefaultRoles < ActiveRecord::Migration
  def self.up
    admin = Role.new(:name => 'admin')
    admin.save!
    user = Role.new(:name => 'user')
    user.save!
  end

  def self.down
    roles = Role.all
    roles.each { |role| role.destroy }
  end
end
