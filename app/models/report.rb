Annotable::Report.class_eval do
  belongs_to :project, optional: true
  belongs_to :organization
  has_many :notes, class_name: 'Note', primary_key: :legacy_id

  def to_param
    self.legacy_id
  end
end
Report = Annotable::Report
