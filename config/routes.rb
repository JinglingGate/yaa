Rails.application.routes.draw do
  get 'api' => 'api#delegate'
  post 'api' => 'api#delegate'
end
