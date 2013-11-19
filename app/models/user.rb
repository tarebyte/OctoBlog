class User < ActiveRecord::Base
  include Tenacity

  extend FriendlyId
  friendly_id :username, use: :slugged

  t_has_many :repos
  t_has_many :posts

  ROLES = %w{ admin member }

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth['info']['nickname']
      user.name     = auth['info']['name'] ? auth['info']['name'] : user.username
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.slug     = user.username
      user.role     = 'member'
    end
  end

  # Meta programming bitch
  # add is_member? and is_admin?
  ROLES.each do |a_role|
    define_method "is_#{a_role}?" do
      role == a_role
    end
  end
end
