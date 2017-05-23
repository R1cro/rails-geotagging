user =  [
  {
    email: 'ateseyko@qulix.com',
    password:              '12345678',
    password_confirmation: '12345678',
    role: 1,
    name: 'R1cro',
  }
]
User.create!(user)

100.times do
  name = "Type-#{rand(1..1000)}"
  DynamicObjectType.find_or_create_by(name: name)
end

500.times do
  name = "Field-#{rand(1..10000)}"
  field_type = 'text_field'
  required = false
  dynamic_object_type_id = rand(1..100)
  DynamicObjectField.find_or_create_by(
    name: name,
    field_type: field_type,
    required: required,
    dynamic_object_type_id: dynamic_object_type_id
  )
end
