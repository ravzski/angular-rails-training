Rails.application.routes.draw do


  api vendor_string: "truck-rms", default_version: 1 do
    version 1 do
      cache as: 'v1' do

        resource :sessions, only: %w(create show destroy)

      end
    end
  end

  get "*path" => "application#index"
  root to: "application#index"

end
