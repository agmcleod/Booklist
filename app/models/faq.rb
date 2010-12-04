class Faq < ActiveRecord::Base
  belongs_to :faq_category
  validates_presence_of :question, :answer
end
