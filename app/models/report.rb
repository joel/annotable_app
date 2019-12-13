class Report < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  has_many :notes
end
