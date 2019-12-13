# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'
require_dependency Rails.root.join('spec/support/helpers.rb')

5.times.each do
  organization = FactoryBot.create(:organization)
  puts("Create Organization #{organization.name} [#{organization.id}]")
  5.times.each do
    user = FactoryBot.create(:user, organization: organization)
    puts("Create User #{user.email} [#{user.id}]")
  end
  5.times.each do
    project = FactoryBot.create(:project, organization: organization)
    puts("Create Project #{project.name} [#{project.id}]")
    5.times.each do
      report = FactoryBot.create(:report, project: project)
      puts("Create Report #{report.name} [#{report.id}]")
      5.times.each do
        note = FactoryBot.create(:note, report: report)
        puts("Create Note #{note.title} [#{note.id}]")
      end
    end
  end
end
