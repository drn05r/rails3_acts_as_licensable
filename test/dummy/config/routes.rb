Rails.application.routes.draw do
  mount Rails3ActsAsLicensable::Engine => "/"
end
