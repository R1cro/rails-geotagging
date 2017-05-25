# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user =  [
  {
    email:                  "admin@admin",
    password:               "12345678",
    password_confirmation:  "12345678",
    role:                   "admin",
    name:                   "admin",
  }
]

User.create!(user)

Faker::Hipster.words(rand(20)).each do |name|
  DynamicObjectType.find_or_create_by(name: name)
end

types = DynamicObjectType.all
users = User.all

types.each do |type|
  rand(10).times do
    name = Faker::Lorem.word.titleize
    field_type = 'text_field'
    required = false
    DynamicObjectField.find_or_create_by(
      name: name,
      field_type: field_type,
      required: required,
      dynamic_object_type_id: type.id
    )
  end
end

100.times do
  dynamic_object_type_id = types.sample.id
  user_id = users.sample.id
  name = Faker::Lorem.word.titleize
  description = Faker::Lorem.sentence(4)
  address = Faker::Address.city + ', ' + Faker::Address.street_address
  latitude = rand(53.872368295977545..53.931735872727586)
  longitude = rand(27.497406005859375.. 27.601776123046875)
  DynamicObject.create!(
    name: name,
    description: description,
    address: address,
    latitude: latitude,
    longitude: longitude,
    dynamic_object_type_id: dynamic_object_type_id,
    user_id: user_id,
    properties: Hash[DynamicObjectType.find(1).fields.map {|field| [field.name, Faker::Lorem.word]}]
  )
end
