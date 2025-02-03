class Current < ActiveSupport::CurrentAttributes
  attribute :user, :session, :organisation
end