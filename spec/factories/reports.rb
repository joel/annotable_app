FactoryBot.define do
  factory :report do
    initialize_with do
      report  = Fabricate.create(:report).reload
      project = FactoryBot.create(:project, organization: report.organization)

      new({
        name: report.name,
        content: report.content,
        organization: report.organization,
        project: project,
      })
    end

    # set back from the database the instance.legacy_id
    after(:create) { |instance| instance.reload }
  end
end
