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

class DynamicObject < ApplicationRecord
  belongs_to :user
  belongs_to :dynamic_object_type
  belongs_to :location

  has_many :connections

  serialize :properties, Hash

  validates :description, presence: true
  validates :name, presence: true
  validate :validate_properties
  
  def validate_properties
    dynamic_object_type.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
