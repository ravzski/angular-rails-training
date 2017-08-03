Rails.application.routes.draw do

  concern :resource_common do
    collection do
      get 'all'
      get 'search_fullname'
    end
  end

  api vendor_string: "truck-rms", default_version: 1 do
    version 1 do
      cache as: 'v1' do

        resources :docks, concerns: :resource_common
        resources :users, concerns: :resource_common
        resources :trucks, concerns: :resource_common do
          member do
            get :transactions
          end
        end
        resources :drivers, concerns: :resource_common
        resources :assistants, concerns: :resource_common
        resources :suppliers, concerns: :resource_common do
          collection do
            get :lookup
          end
        end

        resources :areas, concerns: :resource_common
        resources :roles, concerns: :resource_common
        resources :permissions, concerns: :resource_common
        resources :rfids, concerns: :resource_common do
          collection do
            post :scan
          end
        end
        resources :blacklists, concerns: :resource_common
        resources :rfid_guns, concerns: :resource_common
        resources :ban_reason_types, concerns: :resource_common
        resources :ban_reasons, concerns: :resource_common
        resources :card_types, concerns: :resource_common
        resources :cards, concerns: :resource_common
        resources :contact_details, concerns: :resource_common
        resources :contact_types, concerns: :resource_common
        resources :coordinators, concerns: :resource_common
        resources :drivers, concerns: :resource_common
        resources :stages, concerns: :resource_common
        resources :csv_uploads do
          collection do
            post :upload
          end
        end
        resources :schedules, concerns: :resource_common do
          collection do
            get :poll
            get :get_report
            get :export
          end
        end
        resource :sessions, only: %w(create show destroy)
        resources :dashboard do
          collection do
            get :get_gate_in
            get :get_gate_out
            get :get_dock
            get :get_parking
            get :view_schedule
          end
        end
      end
    end
  end

  get "*path" => "application#index"
  root to: "application#index"

end
