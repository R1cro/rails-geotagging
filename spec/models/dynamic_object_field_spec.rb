# == Schema Information
#
# Table name: dynamic_object_fields
#
#  id                     :integer          not null, primary key
#  name                   :string
#  field_type             :string
#  required               :boolean
#  dynamic_object_type_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_dynamic_object_fields_on_dynamic_object_type_id  (dynamic_object_type_id)
#

require 'rails_helper'

RSpec.describe DynamicObjectField, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
