# == Schema Information
#
# Table name: dynamic_object_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DynamicObjectType < ApplicationRecord
  has_many :fields, class_name: 'DynamicObjectField'
  accepts_nested_attributes_for :fields, allow_destroy: true
end
