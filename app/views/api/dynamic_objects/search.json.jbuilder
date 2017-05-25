json.array! @dynamic_objects do |dyn|
  json.id           dyn.id
  json.type_id      dyn.dynamic_object_type_id
  json.name         dyn.name
  json.description  dyn.description
  json.lat          dyn.latitude
  json.lng          dyn.longitude
  json.bearing      dyn.bearing
end
