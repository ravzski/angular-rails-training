module TokenProcessor
  extend ActiveSupport::Concern

  def set_access_token attributes={}
    self.current_token = SecureRandom.urlsafe_base64(32).tr('lIO0', 'sxyz')
    self.access_tokens.create(attributes.merge({token: self.current_token}))
  end

  def destroy_token
    token = self.access_tokens.find_by(token: self.current_token)
    if token.present?
      # $redis.del("users/#{token}")
      token.update_attribute(:deleted_at, Time.current)
    else
      false
    end
  end

end
