class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  validates_presence_of :email, :display_name
  validates_length_of :password, :in => 8 .. 14, :on => :create
  validates_confirmation_of :password
  validates_uniqueness_of :display_name, :email
  has_and_belongs_to_many :roles
  
  has_many :book_transactions
  
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => 'please provide a valid email address'
  
  has_many :used_books
  
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    unless user.blank?
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user.authenticated = false # set to false, so the controller knows the password is invalid
      else
        user.authenticated = true
      end
    else
      user = nil
    end
    user
  end

  # returns the password variable
  def password
    @password
  end

  # accepts the sent password, and hashes it
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def old_password=(password)
    @old_password = password
  end

  def old_password
    @old_password
  end
  
  def authenticated
    if !@authenticated
      @authenticated = false
    end
    @authenticated
  end
  
  def authenticated=(auth)
    @authenticated = auth
  end
  
  def secure_new_pw(password)
    create_new_salt
    self.hashed_password = User.encrypted_password(password, self.salt)
  end
  
  def self.generate_password
    return User.random_string(9)
  end
  
  def is_admin?
    r = self.roles.find_by_name('admin')
    return true unless r.blank?
  end

  def is_user?
    r = self.roles.find_by_name('user')
    return true unless r.blank?
  end
  
  def is_disabled?
    if self.disabled
      { :checked => true }
    else
      { :checked => false } 
    end
  end

  def confirm_old_password(old_password)
    expected_password = User.encrypted_password(old_password, self.salt)
    logger.debug "#{self.secure_password} #{expected_password}"
    return false if self.secure_password != expected_password
  end
  
private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.random_string(max)
    o = [('a'..'z'),('A'..'Z'), (0 .. 9)].map{|i| i.to_a}.flatten
    return (0 .. max).map{ o[rand(o.length)]  }.join
  end
end
