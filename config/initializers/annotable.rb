require 'annotable'

require Annotable::Engine.root.join('app/controllers/annotable/organizations_controller.rb')

module OrganizationControllerCustomFields
  module ClassMethods
    def allowed_includes
      (super.dup + [:projects]).freeze
    end

    def allowed_filterables
      (super.dup + ['projects_name']).freeze
    end
  end

  def self.prepended(base)
    class << base
      prepend(ClassMethods)
    end
  end
end
Annotable::OrganizationsController.prepend(OrganizationControllerCustomFields)

require Annotable::Engine.root.join('app/controllers/annotable/reports_controller.rb')

module ReportControllerCustomFields
  module ClassMethods
    def allowed_includes
      (super.dup + %i[project notes].freeze).freeze
    end

    def allowed_filterables
      (super.dup + ['project_name']).freeze
    end
  end

  def self.prepended(base)
    class << base
      prepend(ClassMethods)
    end
  end
end
Annotable::ReportsController.prepend(ReportControllerCustomFields)

require Annotable::Engine.root.join('app/serializers/annotable/organization_serializer.rb')

Annotable::OrganizationSerializer.class_eval do
  has_many :projects
end

require Annotable::Engine.root.join('app/serializers/annotable/report_serializer.rb')

Annotable::ReportSerializer.class_eval do
  belongs_to :project
  # has_many :notes
end

module Annotable
  class ProjectSerializer # < BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name
  end
end

module Annotable
  class NoteSerializer # < BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title
  end
end
