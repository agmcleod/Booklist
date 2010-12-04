class PaymentNotificationsController < ApplicationController
  # protect_from_forgery :except => [:create]
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    PaymentNotification.create!(:params => params, :used_book_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end
end
