Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :data_sources, except: [:show]
  get "export_data_sources" => "data_sources#csv_report"
end
