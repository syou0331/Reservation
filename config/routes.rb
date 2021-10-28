Rails.application.routes.draw do
  get 'bookings/index'
  get 'hotels/index'
  get 'users/index'
  get 'users/profile'
  get 'hotels/search'
  root 'top#index'
  post 'hotels/booking_confirm'
  post 'hotels/back'
  post 'hotels/booking_complete'



  #get 'signup', to: 'users#new'


  devise_for :users
  resources :users, only: [:index, :show, :update]
  resources :hotels
  resources :bookings
end