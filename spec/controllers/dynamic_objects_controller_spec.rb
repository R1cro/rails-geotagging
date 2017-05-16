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

require "rails_helper"

RSpec.describe DynamicObjectsController, type: :controller do

end
