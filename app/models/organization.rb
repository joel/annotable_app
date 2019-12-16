Annotable::Organization.class_eval do
  has_many :projects, class_name: 'Project', primary_key: :legacy_id
  def to_param
    self.legacy_id
  end
  def as_json(*)
    super.merge({ 'id' => legacy_id })
      .merge({ 'projects' => projects })
      .except('legacy_id')
  end
end
Organization = Annotable::Organization
