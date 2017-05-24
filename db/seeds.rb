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
  name = type
  DynamicObjectType.find_or_create_by(name: name)
end

100.times do
  name = "Field-#{rand(1..100)}"
  field_type = 'text_field'
  required = false
  dynamic_object_type_id = rand(1..19)
  DynamicObjectField.find_or_create_by(
    name: name,
    field_type: field_type,
    required: required,
    dynamic_object_type_id: dynamic_object_type_id
  )
end
