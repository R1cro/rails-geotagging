user =  [
  {
    email: 'admin@geotagging.com',
    password:              '12345678',
    password_confirmation: '12345678',
    role: 1,
    name: 'Admin',
  }
]
User.create!(user)

object_types = %w(Car Park Parking Bank Shop Zoo Person Cafe Restaurant Gym
                   Casino Hospital Library Museum Club
                   University School Stadium Storage)
object_types.each do |type|
  DynamicObjectType.find_or_create_by(name: type)
end

types = DynamicObjectType.all
users = User.all

70.times do
  name = Faker::Lorem.word.titleize
  field_type = 'text_field'
  required = false
  dynamic_object_type_id = types.sample.id
  DynamicObjectField.find_or_create_by(
    name: name,
    field_type: field_type,
    required: required,
    dynamic_object_type_id: dynamic_object_type_id
  )
end

50.times do
  dynamic_object_type_id = types.sample.id
  user_id = users.sample.id
  name = Faker::Lorem.word.titleize
  description = Faker::Lorem.sentence(7)
  address = Faker::Address.country + ', ' + Faker::Address.city + ', ' + Faker::Address.street_address
  latitude = rand(53.872368295977545..53.931735872727586)
  longitude = rand(27.497406005859375.. 27.601776123046875)
  DynamicObject.find_or_create_by(
    name: name,
    description: description,
    address: address,
    latitude: latitude,
    longitude: longitude,
    dynamic_object_type_id: dynamic_object_type_id,
    user_id: user_id
  )
end
