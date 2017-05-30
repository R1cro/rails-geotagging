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
#  role               :integer
#  auth_token         :string
#
# Indexes
#
#  index_users_on_auth_token  (auth_token)
#  index_users_on_email       (email) UNIQUE
#

class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_many :dynamic_objects
  has_many :comments
  has_many :connections

  devise :database_authenticatable, :registerable, :trackable, :validatable
  validates_presence_of :name

  def make_admin!
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
      user.name = Rails.application.secrets.admin_name
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.admin!
    end
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end
end
