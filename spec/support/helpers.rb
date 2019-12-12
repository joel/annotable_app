# frozen_string_literal: true

def user_attributes
  first_name = FFaker::Name.first_name.gsub("'", '')
  last_name  = FFaker::Name.last_name.gsub("'", '')

  email      = first_name.downcase + '.' + last_name.downcase + FFaker::Internet.email[/@(.*)/]

  {
    name: first_name + ' ' + last_name,
    email: email
  }
end
