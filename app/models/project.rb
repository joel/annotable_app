class Project < ApplicationRecord
  belongs_to(
    :organization,
    class_name: 'Annotable::Organization',
    primary_key: :legacy_id,
    required: true
  )
  validates :name, presence: true
  has_many :reports, class_name: 'Annotable::Report', foreign_key: :project_id
end
