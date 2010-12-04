VirtualBillboard::Application.routes.draw do |map|
  resources :payment_notifications

  resources :tickets

  resources :faqs

  resources :faq_categories

  resources :users
  match '/forgotpassword' => 'users#forgot_password', :as => 'forgot_password'
  match '/users/update_permissions' => 'users#update_permissions', :as => 'update_permissions'
  match '/change_password' => 'users#change_password', :as => 'change_password'
  match '/usercp' => 'users#user_cp', :as => 'user_cp'
  
  root :to => 'used_books#index'
  
  resources :used_books
  match '/browse' => 'used_books#browse', :as => 'browse'
  match '/used_books/new/:isbn' => 'used_books#new', :as => 'new_used_book'
  match '/used_books/:id/buynow' => 'used_books#buy_now', :as => 'buy_now'
  match '/search' => 'search#search', :as => 'search'
  match '/buynow/:id' => 'used_books#buy_now', :as => 'buy_now'
  match '/acceptrequest/:id/:user_id' => 'used_books#accept_buy_request', :as => 'accept_buy_request'
  match '/sendbuyercontactinfo' => 'used_books#send_contact_info', :as => 'send_buyer_contact_info'
  match '/bookissold/:id' => 'used_books#set_book_to_sold', :as => 'set_book_to_sold'
  
  resource  :session
  
  match '/logout' => 'sessions#destroy', :as => 'logout_destroy'
	match '/register' => 'users#new', :as => 'register'
	
	match '/support' => 'support#index', :as => 'support'
end
