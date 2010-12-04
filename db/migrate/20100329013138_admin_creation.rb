class AdminCreation < ActiveRecord::Migration
  def self.up
    admin = User.new(:email => 'superadmin@virtualbulliton.com', :password => 'azuyxwN3r', 
      :password_confirmation => 'azuyxwN3r', :display_name => 'admin')
    admin.roles << Role.find_by_name('admin')
    admin.save!
  end

  def self.down
    admin = User.find_by_email('superadmin@virtualbulliton.com')
    admin.destroy
  end
end
