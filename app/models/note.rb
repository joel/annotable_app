class Note < ApplicationRecord
  belongs_to :report
  validates :title, :content, presence: true
end
