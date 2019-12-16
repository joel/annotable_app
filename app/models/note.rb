class Note < ApplicationRecord
  belongs_to(
    :report,
    class_name: 'Annotable::Report',
    primary_key: :legacy_id,
    required: true
  )
  validates :title, :content, presence: true
end
