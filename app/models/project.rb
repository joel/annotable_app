class Project < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true
  has_many :reports
end
