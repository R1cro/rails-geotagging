# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string
#  last_sign_in_ip    :string
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :farms
  has_many :dynamic_objects
  has_many :comments
  has_many :connections
  
  devise :database_authenticatable, :registerable, :trackable, :validatable
  validates_presence_of :name
  
end
