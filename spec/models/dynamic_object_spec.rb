# == Schema Information
#
# Table name: dynamic_objects
#
#  id                     :integer          not null, primary key
#  name                   :string
#  description            :text
#  address                :string
#  latitude               :float
#  longitude              :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  dynamic_object_type_id :integer
#  properties             :text
#  user_id                :integer
#

require 'rails_helper'

RSpec.describe DynamicObject, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
