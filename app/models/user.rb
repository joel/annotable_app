Annotable::User.class_eval do
  def to_param
    self.legacy_id
  end
  def as_json(*)
    super.merge({ 'id' => legacy_id }).except('legacy_id')
  end
end
User = Annotable::User
