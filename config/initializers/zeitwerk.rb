require 'annotable'

require Annotable::Engine.root.join('app/models/annotable/organization.rb')
require Annotable::Engine.root.join('app/models/annotable/user.rb')
require Annotable::Engine.root.join('app/models/annotable/report.rb')

require Annotable::Engine.root.join('app/serializers/annotable/organization_serializer.rb')
require Annotable::Engine.root.join('app/controllers/annotable/organizations_controller.rb')
require Annotable::Engine.root.join('app/serializers/annotable/report_serializer.rb')
require Annotable::Engine.root.join('app/controllers/annotable/reports_controller.rb')

Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/models/annotable/organization.rb'))
Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/models/annotable/user.rb'))
Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/models/annotable/report.rb'))

Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/serializers/annotable/organization_serializer.rb'))
Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/controllers/annotable/organizations_controller.rb'))
Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/serializers/annotable/report_serializer.rb'))
Rails.autoloaders.main.ignore(Annotable::Engine.root.join('app/controllers/annotable/reports_controller.rb'))

require_dependency Rails.root.join('app/models/organization.rb')
require_dependency Rails.root.join('app/models/user.rb')
require_dependency Rails.root.join('app/models/report.rb')

require_dependency Rails.root.join('config/initializers/annotable.rb')
