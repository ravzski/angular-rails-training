module CommonStatus
  extend ActiveSupport::Concern

  module Status
    Inactive = "inactive"
    Active = "active"
  end

end
