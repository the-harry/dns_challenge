Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :records, only: %i[create] do
          post 'search', to: 'records#search'
      end
    end
  end
end
