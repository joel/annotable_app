class User < ApplicationRecord
  validates :email, presence: true, format: { with: /@/ }
  belongs_to :organization, optional: true
end
