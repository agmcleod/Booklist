class Ticket < ActiveRecord::Base
  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_presence_of :comment, :on => :create, :message => "can't be blank"
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create, :message => "is invalid"
  
  has_many :ticket_updates
  
  def self.status_hash
    statuses = {
      'Open' => 1,
      'In Progress' => 2,
      'Closed' => 3
    }
    statuses.sort { |a, b| a[1] <=> b[1] }
  end

  def self.status_to_s(status)
    hash = self.status_hash
    value = ""
    hash.each do |i, v|
      if v == status
        value = i
      end
    end
    value
  end

  def self.status_to_i(status)
    hash = self.status_hash
    index = 0
    hash.each do |i, v|
      if i.downcase == status.downcase
        index = v
      end
    end
    index
  end
end
