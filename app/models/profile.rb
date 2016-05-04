class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :first_name, presence: true
  validates :last_name, presence: true
end
