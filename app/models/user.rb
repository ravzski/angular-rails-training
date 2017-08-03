class User < ApplicationRecord
  include Authenticable
  include TokenProcessor

  has_many :access_tokens
  belongs_to :role

  attr_accessor :current_token

  # validations
  validates :email,       presence: true
  validates :username,    presence: true, allow_blank: true
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  #--------

  validate :validate_uniquness_on_soft_deleted
  before_save :validate_if_unused

  UNIQUE_COLUMNS = ['email']

  def self.find_by_credentials(creds)
    user = self.find_by(email: creds.fetch(:email, ''))
    user if user.present? && user.valid_password?(creds.fetch(:password, ''))
  end

  def unique_columns
    ['email']
  end

  private

  def validate_if_unused
    if Log.where(ref_id: self.id, ref_type: self.class.name).limit(1).present?
      errors.add(:base,"Sorry, this action is not allowed. This field is being referenced in an activity")
      false
    end
  end

end
