Rails3ActsAsLicensable::Engine.routes.draw do
  resources :licenses, :only => [:index, :show]
end
