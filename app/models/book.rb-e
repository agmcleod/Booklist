require 'amazon/aws/search'

include Amazon::AWS
include Amazon::AWS::Search

class Book < ActiveRecord::Base
  has_many :for_sale, :class_name => "used_book"
  
  def self.get_amazon_data(keywords, type = 'Medium')
    is = ItemSearch.new('Books', { 'Keywords' => keywords })
    rg = ResponseGroup.new(type)
  
    req = Request.new
    req.locale = 'ca'
    resp = req.search(is, rg)
    return resp.item_search_response[0].items[0].item
  end
end
