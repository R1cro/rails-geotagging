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
end
