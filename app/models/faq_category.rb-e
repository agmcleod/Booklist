class FaqCategory < ActiveRecord::Base
  has_many :faqs, :dependent => :destroy
  validates_presence_of :name
end
